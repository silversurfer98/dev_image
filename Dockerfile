FROM alpine/git AS copier
RUN git clone https://github.com/silversurfer98/zsh_setup
FROM ubuntu:jammy
RUN rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN add-apt-repository ppa:neovim-ppa/unstable -y && apt update && apt install locales wget git nano zsh exa unzip fontconfig neovim -y && apt upgrade -y

# create user

# download nerd fonts
RUN mkdir -p /home/$USER/.fonts
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
RUN unzip 

# setup starship

# copy configs



# keep container running
