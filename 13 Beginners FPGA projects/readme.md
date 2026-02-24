# Beginneres FPGA projects

Hey ! if you're here, you most likely want to start FPGA by digging into the typical projects I showased in my youtube video.

Note that this was **not a tutorial**, but rather a way for beginners to get an overview of the process of messing around with FPGA and for you to get an idea of whether or not you want to invest time in one of these projects.

In this repo subfolder, you'll find the raw verilog code I used in the video. Note that It does not include everything that goes around it (block designs, primitives etc..) as these depend on the board / FPGA you bought, and you probably did not get the exact same model as me.

That serves as a good exercice if you really don't want to code yourself or just want a quick exmaple running, you will still have to somewhat undeerstand your specific FPGA vendor's toolchain to instatiate the module and contraint them.

I also did not make these a raw tutorial, as these specific projects are already widely documented for almost any FPGA brand or equivalents.

SIDE NOTE : I will still add guideline in the verilog files as comments, no worries ;) If you have questions, check out the discord, links can be found on the channel.

Anyway, that's it for the disclaimers ! Have fun with your first projects !

- BRH

## Note for VGA project

50-75% of the code from the VGA project is stolen from : https://f-leb.developpez.com/tutoriels/fpga/controleur-vga/

## testbench notes

For the `tb_template.v` you'll find here, you'll find no assertions as I'm trash at writting raw verilog testbenches,. These testbench just instantiate the block designs / top module so we can have waveforms and *visually* check what's going on. Nothing more.