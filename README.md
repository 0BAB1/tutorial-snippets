# ZynQ-Tutorial-Series

This repo contains all the code you need for the toturials, ready to copy and paste

I will also link all the very interesting ressources i talk about in my videos, but also interresting exercices you can do to practice at your own pace.

# 1 : ZynQ in two minutes

[Video](https://www.youtube.com/watch?v=DQHTSelupDs)

This video is all about clarifying what ZynQ is and how it use FPGAs at its advantage.

## Code

There is no code necessary for this video

## Ressources

I really suggest your read "the Zynq book" for more informations :
- [Zynq book PDF](https://is.muni.cz/el/1433/jaro2015/PV191/um/The_Zynq_Book_ebook.pdf)

# 2 : AXI IP, Hello world & custom LED driver

[Video](https://www.youtube.com/@BRH_SoC)

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
