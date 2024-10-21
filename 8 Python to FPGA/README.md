# Python to FPGA video

> [!IMPORTANT]  
> This is a preview and this is subject to (a lot of) changes and additions during the new couple of weeks.
> In the meantime, you can do the tutorial on your own (it was actually made to be done alone so don't worry) and you can open issues and PR if you think something is off ;)

This folder contains EVERYTHING you need to kickstart your FPGA AI projects.

To make the video as enjoyable as possible (It is not course, because I sell the actual course to universities), I made the choice to let the viewer do its own research when it comes to the various details **BUT** you are not alone ! This README acts like a small course with all of the ressources nedded for a full understanding of what you are doing.

## Pre-requesites

### Before listing the prerequisites...

Here are the things you need to get started. If you don't know or understand something :
- Regarding harware tools : take a look on my channel, I have basic tutorials to learn hardware project workflows
- Regarding knowledge : Take a look at the resources below
- Regarding docker, linux, basic stuff : do your research, internet is full of tutorials for these.

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

## Let's get to work !

> Okay, so where do I start ? What do I do now ? <br> - You (maybe)

Well here is how I suggest you go about this :

- First, watch the first video availible [here](https://www.youtube.com/watch?v=lJa4dqdAsUM)
- Then, watch the entire tutorial to understand what to do and identify the things you have to learn. 
- Set up your dev environement, c.f. ressources below for the official up-to-date tutorial from FINN (fairly simple) **AND** the notes on preparing the dev environement just below this bullet list
- After that, clone this repo and cd in this sub directory and simply follow the notebook instructions.

If you have a doubt, come back to the video or use the ressources below to learn more about each and every points of interest.

### Preparing the dev environement

You have the official tutorial in the resources but here are some points of attention :
- use ```bash run-docker.sh notebook``` command and **NOT** ```bash run-docker.sh notebook```
- It will give you the jupyter URL
- If you use your notebook in VSCODE, simply :
    - Select kernel...
    - Exsting Jupyter server..
    - Paste in the URL that looks like this : ```http://127.0.0.1:8888/tree?token=<RANDOM_STUFF>```
- If you use Jupyter : simply go on the URL : ```http://127.0.0.1:8888/tree?token=<RANDOM_STUFF>```


### Your coding starting point

Once you dev environement is set up, you can start with the first notebook explaining how to use Brevitas using a simple FC net on FashionMNIST.

Every notbook is in this subfolder sub dir.

### Regarding The Manual Infernce

Manual inference implies you use code snippets and Xilinx tools rather than a notebook, material will be located in a dedicated sub-directory.

See you on the other side !

## Ressources

If you want to truly understand what you are doing and become proficient in engineering, these ressources are your go-to.

I personnally used ALL of these ressources, so I will anotate some tips with each one so you don't have to waste time on less valuable knowledge.

| Resource name | Link | Comment |
|---|---|---|
| FINN : notebooks | [GitHub repo](https://github.com/Xilinx/finn/tree/main/notebooks) | **MOST** of my tutorial material is based on these noptebooks, **HUGE** credit to the FINN dev team ! |
| FINN : setup dev environement | [Link](https://finn.readthedocs.io/en/latest/getting_started.html#running-finn-in-docker) | Lunch a notebook environement in docker. Note : use ```bash``` command and **NOT** ```sh```|
| My tutorials on Xilinx's HW tools and ZYNQ FPGA | [Youtube playlist](https://www.youtube.com/watch?v=DQHTSelupDs&list=PLCn4eX6oSgMbgI4WERry0XnHiVysNqtGc) | To get started on all the hardware tools we'll use, from A to Z, fast. |
| Quantization | [Youtube Link](https://www.youtube.com/watch?v=0VdNflU08yA) | Watch it all, great lecture |
| Quantization : 2 | [Paper link](https://arxiv.org/pdf/2106.08295) | Great paper, very accessible for ost people. *(You can skip the backward propagation part.)* |
| Streamlining | [Paper link](https://arxiv.org/pdf/1709.04060) | Streamlining is the main FINN "math transformation" of our model that will convert it to fully integer (some QQN still have FP bias for example). After that, we only have INTs in the model, making it MUCH easier to work with in hardware. |
| FINN : how does it work | [Paper 1 Link](https://arxiv.org/pdf/1612.07119) <br> [Paper 2 Link](https://arxiv.org/pdf/1809.04570) | Very nice papers explaining how FINN operate to generate HW from streamlined model (also benchmarks). 1st was on the previous FINN version on Binary Neural Networks (BNN) which make it easier to read in my opinion.|
