# This is a list of the commands i ran in the video
# WARNING : This file is .sh for syntax only and is NOT meant to be executed

# Install petalinux.
# LINK : https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html

# Choose an installation path and let it install. You might have to install a bunch of libraries to make wrning and errors go away

# Then everything is pretty self explainatory and here are the commands :

source ./settings.sh .

petalinux-create project --template zynq --name /path/to/your/project

petalinux-config --get-hw-description /path/to/XSA

# takes a long time, go for a walk (almost mandatory)
petalinux-build

cd ./images/linux
petalinux-package --boot --fsbl zynq_fsbl.elf --u-boot u-boot.elf --fpga system.bit --force

# If you want to know more about First Stage and Second Stage Boot loadeers, see the README.md at the root of the repo in this vide ressource, i will give ressources on that (Zynq book)

# once on your board's UART : get its ip with :
ifconfig

# you can then SSH into it using :

ssh petalinux@your.board.ip

# on your main machine