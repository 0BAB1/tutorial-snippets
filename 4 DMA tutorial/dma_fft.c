#include "xparameters.h"
#include "xaxidma.h"
#include <stdio.h>
#include <xstatus.h>
#include "complex.h"

#define FFT_POINTS 8

XAxiDma AxiDma;
int init_dma(XAxiDma *AxiDma){
    XAxiDma_Config* CfgPtr;
    int status;

    // Look up the configuration in the hardware configuration table
    CfgPtr = XAxiDma_LookupConfig(XPAR_AXI_DMA_0_BASEADDR);
    if (!CfgPtr) {
        printf("No configuration found for %d\n", XPAR_AXI_DMA_0_BASEADDR);
        return XST_FAILURE;
    }

    // Initialize the DMA handle with the configuration structure
    status = XAxiDma_CfgInitialize(AxiDma, CfgPtr);
    if (status != XST_SUCCESS) {
        printf("Initialization failed\n");
        return XST_FAILURE;
    }

    // Check for Scatter Gather mode, which is not supported in this example
    if (XAxiDma_HasSg(AxiDma)) {
        printf("Device configured as SG mode\n");
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}

int main(void){
    int status = init_dma(&AxiDma);
    if(status != XST_SUCCESS){
        printf("Error while initialize the DMA");
        return 1;
    }

    // data buffers that will live in memory
    float complex RxBuffer[FFT_POINTS] __attribute__ ((aligned (32)));
    float complex TxBuffer[FFT_POINTS] __attribute__ ((aligned (32)));

    //fill tx buffer with actual data
    for(int i = 0; i < FFT_POINTS; i++){
        TxBuffer[i] = i;
    }

    // flush the cache
    Xil_DCacheFlushRange((UINTPTR)RxBuffer, FFT_POINTS * sizeof(float complex));
    Xil_DCacheFlushRange((UINTPTR)TxBuffer, FFT_POINTS * sizeof(float complex));



    // START TRANFER
    status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)TxBuffer, FFT_POINTS * sizeof(float complex), XAXIDMA_DMA_TO_DEVICE);
    if (status != XST_SUCCESS) {
        printf("DMA transfer to FFT failed\n");
        return XST_FAILURE;
    }

    status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)RxBuffer, FFT_POINTS * sizeof(float complex), XAXIDMA_DEVICE_TO_DMA);
    if (status != XST_SUCCESS) {
        printf("DMA transfer from failed\n");
        return XST_FAILURE;
    }

    while (1) {
        if (!(XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA)) &&
            !(XAxiDma_Busy(&AxiDma, XAXIDMA_DMA_TO_DEVICE))) {
            break;
        }
    }

    // make sure to use printf() / not xil_printf() here
    for(int i = 0; i < FFT_POINTS; i++){
        printf("FPGA valeur RxBuffer[%d] = %.2f   %.2f i\n", i, crealf(RxBuffer[i]), cimagf(RxBuffer[i]));
    }


    return 0;
}