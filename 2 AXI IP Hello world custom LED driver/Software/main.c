#include <stdio.h>
#include "xparameters.h"

// give a better name to our base addres (from xparameters.h)
// REPLACE "XPAR_LED_IP_0_BASEADDR" with YOUR base address name
// (search in xparameters.h, you'll find it !)
// or directly the you took from vivado
#define LED_ADDR XPAR_LED_IP_0_BASEADDR

int main(void){

    //write a 1 to led base address
    int* ptr = LED_ADDR; // declare a pointer
    *ptr = 0x1; // write 1 in the register at that adress

    // this will go though our axi hardware
    // and make an AXI LITE trasction to our IP
    // and the rest is history (you wrote the HDL after all !)

    return 0;
}