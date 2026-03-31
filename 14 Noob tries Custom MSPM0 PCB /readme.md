# MSPM0 - Software side

You find all you need here to run software on you MSM0 PCB.

- Actual C code for CCstudio
- OpenOCD config files for STLINKv2 target
- Python parser & interpretor for nice view (optional, you can just use a raw uart terminal)

For more guidance, I explain everythin in this video review : https://www.youtube.com/watch?v=zaCDn2uz6gs

## C code, what does it do ?

Simply reads from I2C sensors (polling + sensord secific I2C coms specs) and sends results to UART.

> Note: Phil forgor to wire I2C sensor I2C addr set pin to Vcc or GND, effectively leavin this pin floating. Now this is pretty bad but the sensir wil have 1 of 2 adresses (in a resumed random fashion) so the C code runs a small deiscovy loop at the beginnning to figure ou which address is the right one.
