FROM ubuntu:jammy
RUN add-apt-repository ppa:neovim-ppa/unstable -y && apt update && apt install wget git nano zsh exa unzip fontconfig neovim -y
RUN mkdir -p /home/$USER/.fonts
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
RUN unzip 

