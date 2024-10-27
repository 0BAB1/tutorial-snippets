# Python to FPGA video : Kickstart your FPGA AI Projects

> [!IMPORTANT]  
> This is a "DIY" tutorial derived from my 9 hours course. As I cannot teach all the different concepts here, you'll have access to all the ressources you need to learn. If you go from 0 (given that you have some basis on FPGA and all) I'd say this project can that a few days to comlete with a good understanding. Hop you enjoy this project, godd luck, and see you on the other side !

This folder contains EVERYTHING you need to kickstart your FPGA AI projects.

> It contains a FULL TUTORIAL meant to be "DIY" in which you will be guided to deploy your own AI model on FPGA !

To make the video as enjoyable as possible (It is not course, because I sell the actual course to universities), I made the choice to let the viewer do its own research when it comes to the various details **BUT** you are not alone ! This README acts like a small course with all of the ressources nedded for a full understanding of what you are doing.

## What will you find in this repo

### PART 0 : This readme

The goal of this readme is to serve a "lighthouse" to which you come and go to gather ressources and tips and various stuff to complete this project at you own pace.

> I recommend you read it fully before starting the PART 1.

You have some explainations below on where and how to start this project.

### PART 1 (Notebook) : Create and train your first QNN

Using brevitas, you will empower Quantize Aware Training to create and train a classifier that you recognize samples from the FasionMNIST dataset.

The notbooks will have plenty of explaination and you can you the ressources at the end of this readme to fill any hole in your understanding.

### PART 2 (Notebook) : Use FINN to convert you QNN to hardware

Learn how to use FINN to manipulate an ONNX graph until the said graph has been reduced to a hardware representation

### PART 3 (Vivado & Vitis) : Run a simple manual inference application

If you know your way around Vivado and vitis, this is a great exercice ! Create a SoC, code a firmware for the DMA and finally, get you results through UART, from a model exclusively ran on FPGA ! YOUR OWN FPGA hardware !

You'll have a separate readme for PART 3, but more on that below :)

## Pre-requesites

### Before listing the prerequisites

Regarding knowledge and understanding, you might not understand everything layed down here :

- Regarding harware tools : take a look on my channel, I have basic tutorials to learn hardware project workflows
- Regarding knowledge : Take a look at the resources below

### Actual prerequisites

- Install [Vivado, Vitis & Vitis HLS](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2023-2.html), tutorial done with 2023.2 version.
- Linux, or good mastering of your docker windows environment (please use linux).
- Some knowledge on :
  - AI, Python, C, Pytorch
  - Data and network quantization
  - Vivado, Vitis
  - HLS (you just need to know it exists as FINN will handle it)
  - Docker, linux, Jupyter notebooks
  - ONNX (You can learn that along the way don't worry, but [look it up](https://fr.wikipedia.org/wiki/Open_Neural_Network_Exchange) on if needed)
  - And of course, FPGAs
- Have a FPGA board. If you have a PYNQ compatible board, you can skip the manual inference part

## All set ? Let's get to work

> Okay, so where do I start ? What do I do now ? <br> - You (maybe)

Well here is how I suggest you go about this :

- First, watch the "[tutorial](https://www.youtube.com/watch?v=VsXMlSB6Yq4)" that sumarizes what we'll do here.
- Set up your dev environement, c.f. ressources below for the official up-to-date tutorial from FINN (fairly simple) **AND** the notes on preparing the dev environement just below this bullet list
- After that, clone this repo and cd in this sub directory and simply follow the notebook instructions, by starting from PART 1 obvbiously ;)

If you have a doubt, come back to the video or use the ressources below to learn more about each and every points of interest.

### Preparing the dev environement

You have the official tutorial in the resources but here are some points of attention :

- use `bash run-docker.sh notebook` command and **NOT** `sh run-docker.sh notebook`
- It will give you the jupyter URL
- If you use your notebook in VSCODE, simply :
  - Select kernel...
  - Exsting Jupyter server..
  - Paste in the URL that looks like this : `http://127.0.0.1:8888/tree?token=<RANDOM_STUFF>`
- If you use Jupyter : simply go on the URL : `http://127.0.0.1:8888/tree?token=<RANDOM_STUFF>`

### Your coding starting point

Once you dev environement is set up, you can start with the first notebook explaining how to use Brevitas using a simple FC net on FashionMNIST.

Every notbook is in this subfolder sub dir.

### Regarding The Manual Infernce

Manual inference implies you use code snippets and Xilinx tools rather than a notebook, material will be located in a dedicated sub-directory. Alongside another [specialized README](./3_manual_inference/README.md) to help you figuring it out.

See you on the other side !

## General Ressources

> [!IMPORTANT]  
> Notebooks also contains context-dependant ressources to explore and understand important topics.

If you want to truly understand what you are doing and become proficient in engineering, these ressources are your go-to.

I personnally used ALL of these ressources, so I will anotate some tips with each one so you don't have to waste time on less valuable knowledge.

| Resource name                                   | Link                                                                                                    | Comment                                                                                                                                                                                                                                       |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| FINN : notebooks                                | [GitHub repo](https://github.com/Xilinx/finn/tree/main/notebooks)                                       | **MOST** of my tutorial material is based on these noptebooks, **HUGE** credit to the FINN dev team !                                                                                                                                         |
| FINN : setup dev environement                   | [Link](https://finn.readthedocs.io/en/latest/getting_started.html#running-finn-in-docker)               | Lunch a notebook environement in docker. Note : use `bash` command and **NOT** `sh`                                                                                                                                                           |
| My tutorials on Xilinx's HW tools and ZYNQ FPGA | [Youtube playlist](https://www.youtube.com/watch?v=DQHTSelupDs&list=PLCn4eX6oSgMbgI4WERry0XnHiVysNqtGc) | To get started on all the hardware tools we'll use, from A to Z, fast.                                                                                                                                                                        |
| Quantization                                    | [Youtube Link](https://www.youtube.com/watch?v=0VdNflU08yA)                                             | Watch it all, great lecture                                                                                                                                                                                                                   |
| Quantization : 2                                | [Paper link](https://arxiv.org/pdf/2106.08295)                                                          | Great paper, very accessible for ost people. _(You can skip the backward propagation part.)_                                                                                                                                                  |
| Streamlining                                    | [Paper link](https://arxiv.org/pdf/1709.04060)                                                          | Streamlining is the main FINN "math transformation" of our model that will convert it to fully integer (some QQN still have FP bias for example). After that, we only have INTs in the model, making it MUCH easier to work with in hardware. |
| FINN : how does it work                         | [Paper 1 Link](https://arxiv.org/pdf/1612.07119) <br> [Paper 2 Link](https://arxiv.org/pdf/1809.04570)  | Very nice papers explaining how FINN operate to generate HW from streamlined model (also benchmarks). 1st was on the previous FINN version on Binary Neural Networks (BNN) which make it easier to read in my opinion.                        |
| Write you own DMA firmware                      | [Youtube link](https://www.youtube.com/watch?v=aySO9jCKj9g)                                             | This video is from me and explains everything you need to know on DMA. You can also simply copy-paste the firmaware I wrote but this is interresting to have better understanding if needed.                                                  |
