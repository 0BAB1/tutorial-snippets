# ZynQ-Tutorial-Series

This repo contains all the code you need for the toturials, ready to copy and paste

I will also link all the very interesting ressources i talk about in my videos, but also interresting exercices you can do to practice at your own pace.

I suggest that you go and check wikipedia for each subject you struggle with as it always offers a nice overview, which is nice to start with a right mindset.

# 1 : ZynQ in two minutes

[Video](https://www.youtube.com/watch?v=DQHTSelupDs)

This video is all about clarifying what ZynQ is and how it use FPGAs at its advantage.

## Code

There is no code necessary for this video

## Ressources

I really suggest your read "the Zynq book" for more informations :
- [Zynq book PDF](https://is.muni.cz/el/1433/jaro2015/PV191/um/The_Zynq_Book_ebook.pdf)

# 2 : AXI IP, Hello world & custom LED driver

[Video](https://www.youtube.com/watch?v=zJJTxOT37K4)

## Code

In the video's directory you will find:
- Verilog code for the top wrapper
- Verilog code for the AXI protocol handler in which we add our submodule
- Verilog code for the submodule
- Constraint file to "link" the IP's output to the LED's pin
- The main.c file for the sofware part

## Ressources

- [Xilinx AXI VIP as a master to verify your IP](https://support.xilinx.com/s/article/1058302?language=en_US)
- [Xilinx AXI VIP, use it for your projects & access testbenches](https://www.xilinx.com/video/hardware/how-to-use-axi-verification-ip-to-verify-debug-design-using-simulation.html)
- [A reddit post I made when I was stuggling on AXI](https://www.reddit.com/r/FPGA/comments/1dbtp6r/problems_implementing_basic_ips_on_axi_lite/)

# 3 : An introduction to HDLs

[Video](https://www.youtube.com/watch?v=9wNddNaA_1o)

## Code

In the video's directory you will find:
- just the basic hdl and constraints so you have a basic template

## Ressources

- [F4PGA : Some open source stuff do do synthesis](https://f4pga.org/)

# 4 : DMA Tuturial with an FFT IP

[Video](https://youtu.be/aySO9jCKj9g)

## Code

In the video's directory you will find:
- dma_fft.c : The main file that I took you through during the video

IMPORTANT NOTE : do not use xil_printf() but rather printf() to handle the display of floats correctly.

## Ressources

- [Video inspired by this LAB, I strongly recommend you check out the others (even tho the sound quality is not great)](https://www.youtube.com/watch?v=6OU0ASEIUJg)