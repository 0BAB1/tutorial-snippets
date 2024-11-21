# BRH Tutorials - Code Github repo

> [!TIP]
> Contributions are welcome ! Especially since I'm prone to mistakes ;) You can also check out the [blog](https://0bab1.github.io/BRH/) where you have additional informations for each tutorial, *but also exclusive content related to engineering in general and bonus tutorials to learn more valuable stuff on a text format*.

This repo contains **all the code you need** for the tutorials, ready to copy and paste.

It also contains **links to the associated [blog posts](https://0bab1.github.io/BRH/)** where you'll find additional tips & resources if you want to do it yourself or push the concepts I discuss a bit further.

I will also link all the very interesting ressources that helped me in my own learning journey for the curious among you.

> [!TIP]
> In the future, I will focus more on "Project reviews" on youtube and post actual technical tutorials here and on the blog. Stay tuned !

# Table of Contents

1. [ZynQ in two minutes](#1--zynq-in-two-minutes)
2. [AXI IP, Hello world & custom LED driver](#2--axi-ip-hello-world--custom-led-driver)
3. [An introduction to HDLs](#3--an-introduction-to-hdls)
4. [DMA Tutorial with an FFT IP](#4--dma-tuturial-with-an-fft-ip)
5. [Quick Petalinux Example for Zynq](#5--quick-petalinux-example-for-zynq)
8. [Python AI to FPGA](#8--python-ai-model-to-fpga)


# 1 : ZynQ in two minutes

[Video](https://www.youtube.com/watch?v=DQHTSelupDs)

This video is all about clarifying what ZynQ is and how it use FPGAs at its advantage.

## Code

There is no code necessary for this video

## Blog post

Find the blog post [here](https://0bab1.github.io/BRH/posts/Zynq_in_120s/)

# 2 : AXI IP, Hello world & custom LED driver

[Video](https://www.youtube.com/watch?v=zJJTxOT37K4)

## Code

In the video's directory you will find:

- Verilog code for the top wrapper
- Verilog code for the AXI protocol handler in which we add our submodule
- Verilog code for the submodule
- Constraint file to "link" the IP's output to the LED's pin
- The main.c file for the sofware part

## Blog post

Find the blog post [here](https://0bab1.github.io/BRH/posts/Axi_led_ip/)

# 3 : An introduction to HDLs

[Video](https://www.youtube.com/watch?v=9wNddNaA_1o)

## Code

In the video's directory you will find:

- just the basic hdl and constraints so you have a basic template, nothing fancy

## Blog post

Find the blog post [here](https://0bab1.github.io/BRH/posts/HDL_in_120s/)

# 4 : DMA Tuturial with an FFT IP

[Video](https://youtu.be/aySO9jCKj9g)

## Code

In the video's directory you will find:

- dma_fft.c : The main file that I took you through during the video

**IMPORTANT NOTE :** do not use xil_printf() but rather printf() to handle the display of floats correctly.

## Blog post

Find the blog post [here](https://0bab1.github.io/BRH/posts/DMA_FFT_ON_ZYNQ/)

# 5 : Quick Petalinux Example for Zynq

Summer is here ! Lighthearted video, more or less entertainement but keeping in mind the objective of delivering fast and technicals infos for you to enjoy !

[Video](https://www.youtube.com/watch?v=SUBGtxwq7RY)

## Code

In the video's directory you will find:

- commands.sh : a file (*NOT MEANT FOR EXECUTION*) with a list of the commands alongside some tips

IMPORTANT NOTE : do not use xil_printf() but rather printf() to handle the display of floats correctly.

## Blog Post

There is no blog post for this one, but here are some resources :

- [Learn a LOT more on Linux for embedded application and FPGA on the Zynq book PDF (from page 385 chapter 22 to chapter 24)](https://is.muni.cz/el/1433/jaro2015/PV191/um/The_Zynq_Book_ebook.pdf)
- [Download Petalinux Here](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html)

Here are the topics covered in this ressource :

- Chapter 22 _Linux an overview_ : understand the basic of linux to get some context
- Chapter 23 _The linux kernel_ : pretty interresting but not useful to understand booting here
- Chapter 24 _Linux booting_ : FSBL, SSBL, U-BOOT etc... are discussed

Combined with the video, this 1 hour read should give you a great overview on Linux for embedded solution in no time (in 1/2 day of learning, worth it) !

# 8 : Python AI Model to fpga

THANK YOU SO MUCH for the success of the intro video !!! But now, Let's get serious : time for the actual tutorial, and it's a BIG one !

[Video](https://www.youtube.com/@BRH_SoC)

## Code

In the video's directory you will find:

- ALL THE RESSOURCES

> This video is a big one, It has its own [Readme file](./8%20Python%20to%20FPGA//README.md). See you there !

## Resources & Blog Post

C.f. the [Readme file](./8%20Python%20to%20FPGA//README.md).

You can also find the blog post [here](https://0bab1.github.io/BRH/posts/PY2FPGA/) for building the model's IP using FINN and [here](https://0bab1.github.io/BRH/posts/FPGA_MANUAL_INFERENCE/) to run manual inference on Zynq.
