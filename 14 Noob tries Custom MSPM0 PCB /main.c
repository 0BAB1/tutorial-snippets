#include "ti_msp_dl_config.h"
#include "ti/driverlib/dl_uart.h"
#include <stdio.h>
#include <stdint.h>

/* ── LIS2DH12 I2C address (SA0 pin low = 0x18, high = 0x19) ── */
// #define LIS2DH12_ADDR           (0x18)

/* ── LIS2DH12 Register map ── */
#define LIS2DH12_WHO_AM_I       (0x0F)   /* should return 0x33 */
#define LIS2DH12_CTRL_REG1      (0x20)
#define LIS2DH12_CTRL_REG4      (0x23)
#define LIS2DH12_STATUS_REG     (0x27)
#define LIS2DH12_OUT_X_L        (0x28)

/*
 * CTRL_REG1: ODR=100Hz, low-power off, X/Y/Z enabled
 *   ODR[3:0]=0101 (100Hz), LPen=0, Zen=1, Yen=1, Xen=1
 *   => 0x57
 */
#define LIS2DH12_CTRL_REG1_VAL  (0x57)

/*
 * CTRL_REG4: BDU=1, FS=±2g, HR=1
 *   BDU=0, BLE=0, FS[1:0]=00 (±2g), HR=1, ST=00, SIM=0
 *   => 0x88
 */
#define LIS2DH12_CTRL_REG4_VAL  (0x08)

/* Multi-byte read: set MSB of sub-address (auto-increment) */
#define LIS2DH12_MULTI_READ     (0x80)

/* ── I2C helpers ── */
static volatile uint32_t gDelayCycles;

static void i2c_calc_delay(void)
{
    DL_I2C_ClockConfig cfg;
    uint32_t clkFreq;
    DL_I2C_getClockConfig(I2C_INST, &cfg);
    clkFreq = (cfg.clockSel == DL_I2C_CLOCK_BUSCLK) ? 32000000 : 4000000;
    gDelayCycles = (3 * (cfg.divideRatio + 1)) * (CPUCLK_FREQ / clkFreq);
}

/* Actual I2C R/W */

static bool i2c_write_reg(uint8_t addr, uint8_t reg, uint8_t val)
{
    uint8_t buf[2] = {reg, val};

    while (!(DL_I2C_getControllerStatus(I2C_INST) & DL_I2C_CONTROLLER_STATUS_IDLE));

    /* Flush any stale data from a previous failed transaction */
    DL_I2C_flushControllerTXFIFO(I2C_INST);

    DL_I2C_fillControllerTXFIFO(I2C_INST, buf, 2);

    DL_I2C_startControllerTransfer(I2C_INST, addr,
                                   DL_I2C_CONTROLLER_DIRECTION_TX, 2);
    delay_cycles(gDelayCycles);
    while (DL_I2C_getControllerStatus(I2C_INST) & DL_I2C_CONTROLLER_STATUS_BUSY);
    if (DL_I2C_getControllerStatus(I2C_INST) & DL_I2C_CONTROLLER_STATUS_ERROR)
        return false;
    while (!(DL_I2C_getControllerStatus(I2C_INST) & DL_I2C_CONTROLLER_STATUS_IDLE));
    return true;
}

static bool i2c_read_regs(uint8_t addr, uint8_t reg, uint8_t *dst, uint8_t len)
{
    uint8_t subaddr = reg;

    while (!(DL_I2C_getControllerStatus(I2C_INST) & DL_I2C_CONTROLLER_STATUS_IDLE));
    DL_I2C_flushControllerTXFIFO(I2C_INST);
    DL_I2C_fillControllerTXFIFO(I2C_INST, &subaddr, 1);

    DL_I2C_startControllerTransfer(I2C_INST, addr,
                                   DL_I2C_CONTROLLER_DIRECTION_TX, 1);
    delay_cycles(gDelayCycles);
    while (DL_I2C_getControllerStatus(I2C_INST) & DL_I2C_CONTROLLER_STATUS_BUSY);
    if (DL_I2C_getControllerStatus(I2C_INST) & DL_I2C_CONTROLLER_STATUS_ERROR)
        return false;
    while (!(DL_I2C_getControllerStatus(I2C_INST) & DL_I2C_CONTROLLER_STATUS_IDLE));

    delay_cycles(gDelayCycles);   /* let bus settle before repeated START */

    DL_I2C_startControllerTransfer(I2C_INST, addr,
                                   DL_I2C_CONTROLLER_DIRECTION_RX, len);
    for (uint8_t i = 0; i < len; i++) {
        while (DL_I2C_isControllerRXFIFOEmpty(I2C_INST));
        dst[i] = DL_I2C_receiveControllerData(I2C_INST);
    }
    return true;
}

/* ── UART helpers ── */
static void uart_send_string(const char *str)
{
    while (*str) {
        DL_UART_Main_transmitDataBlocking(UART0, *str++);
        while (DL_UART_Main_isBusy(UART0));
    }
}

/* Minimal itoa for signed 32-bit (no printf needed) */
static void uart_send_int(int32_t val)
{
    char buf[12];
    int  idx = 0;

    if (val < 0) {
        DL_UART_Main_transmitDataBlocking(UART0, '-');
        while (DL_UART_Main_isBusy(UART0));
        val = -val;
    }
    if (val == 0) { uart_send_string("0"); return; }

    while (val > 0) { buf[idx++] = '0' + (val % 10); val /= 10; }
    for (int i = idx - 1; i >= 0; i--) {
        DL_UART_Main_transmitDataBlocking(UART0, buf[i]);
        while (DL_UART_Main_isBusy(UART0));
    }
}

/* ── Main ── */
int main(void)
{
    SYSCFG_DL_init();
    i2c_calc_delay();
    delay_cycles(4000000);

    uart_send_string("\r\nV7 LIS2DH12 init...\r\n");

    /* ── Discover I2C address ── */
    uint8_t sensor_addr = 0x00;
    uint8_t candidates[2] = {0x18, 0x19};

    for (uint8_t i = 0; i < 2; i++) {
        uint8_t who = 0;
        uart_send_string("Trying 0x");
        uart_send_int(candidates[i]);
        uart_send_string("... ");

        if (i2c_read_regs(candidates[i], LIS2DH12_WHO_AM_I, &who, 1) && who == 0x33) {
            sensor_addr = candidates[i];
            uart_send_string("OK! WHO_AM_I=0x33\r\n");
            break;
        }
        uart_send_string("no response\r\n");
    }

    if (sensor_addr == 0x00) {
        uart_send_string("FATAL: sensor not found on 0x18 or 0x19. Halting.\r\n");
        while (1);
    }

    /* ── Configure sensor (pass sensor_addr from here on) ── */
    if (!i2c_write_reg(sensor_addr, LIS2DH12_CTRL_REG4, LIS2DH12_CTRL_REG4_VAL)) {
        uart_send_string("CTRL_REG4 write FAIL\r\n"); while (1);
    }
    if (!i2c_write_reg(sensor_addr, LIS2DH12_CTRL_REG1, LIS2DH12_CTRL_REG1_VAL)) {
        uart_send_string("CTRL_REG1 write FAIL\r\n"); while (1);
    }
    uart_send_string("Sensor configured. Streaming...\r\n");

    /* ── We shall double check our writes by reading ── */
    uint8_t reg4_read;
    i2c_read_regs(sensor_addr, LIS2DH12_CTRL_REG4, &reg4_read, 1);
    uart_send_string("CONTROL REG4 = ");
    uart_send_int(reg4_read);
    uart_send_string("\n\r");
    if(reg4_read != LIS2DH12_CTRL_REG4_VAL){
        uart_send_string("CONTROL REG4 WAS NOT WRITTEN PROPERLY ! HALTING.\n\r");
        while (1); // HALT
    }

    uint8_t reg1_read;
    i2c_read_regs(sensor_addr, LIS2DH12_CTRL_REG1, &reg1_read, 1);
    uart_send_string("CONTROL REG1 = ");
    uart_send_int(reg1_read);
    uart_send_string("\n\r");
    if(reg1_read != LIS2DH12_CTRL_REG1_VAL){
        uart_send_string("CONTROL REG1 WAS NOT WRITTEN PROPERLY ! HALTING.\n\r");
        while (1); // HALT
    }

    /* ── STATUS CHECKS ── */
    while (1) {
        uint8_t status;
        uart_send_string("Reading status...\r\n");
        do {
            i2c_read_regs(sensor_addr, LIS2DH12_STATUS_REG, &status, 1);
            uart_send_string("Status = ");
            uart_send_int(status);
            uart_send_string("\n\r");
            if (status == 0) {
                delay_cycles(32000000);
            }
        } while (!(status & 0x08));

        uint8_t raw[6];
        uart_send_string("Reading X_L...\r\n");
        i2c_read_regs(sensor_addr, LIS2DH12_OUT_X_L | LIS2DH12_MULTI_READ, raw, 6);

        uart_send_string("Processing data...\r\n");
        int16_t x_mg = (int16_t)((raw[1] << 8) | raw[0]) >> 4;
        int16_t y_mg = (int16_t)((raw[3] << 8) | raw[2]) >> 4;
        int16_t z_mg = (int16_t)((raw[5] << 8) | raw[4]) >> 4;

        uart_send_string("Result:\r\n");
        uart_send_string("X: ");  uart_send_int(x_mg); uart_send_string(" mg  ");
        uart_send_string("Y: ");  uart_send_int(y_mg); uart_send_string(" mg  ");
        uart_send_string("Z: ");  uart_send_int(z_mg); uart_send_string(" mg\r\n");

        delay_cycles(3200000);
    }
}
