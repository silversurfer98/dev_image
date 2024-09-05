# base image
FROM ubuntu:jammy

# my arguments
ARG USERNAME=raghav
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG HOME=/home/$USERNAME

# install all softwares and update certs
RUN apt update && apt install software-properties-common ca-certificates -y \
    && update-ca-certificates \
    && add-apt-repository ppa:neovim-ppa/unstable -y \
    && apt install locales wget git nano zsh exa unzip fontconfig neovim sudo build-essential ripgrep curl -y \
    && apt upgrade -y

# create user and group
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && chown -R $USERNAME:$USERNAME $HOME

# THERE IS PROBLEM RELATED TO useradd, if u create a user using useradd the home folder is owned by root, so chown it

# create locales
RUN rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# switch to user
USER $USERNAME

# download nerd fonts
RUN mkdir -p $HOME/.fonts
WORKDIR $HOME/.fonts
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
RUN unzip FiraCode.zip -d $HOME/.fonts && fc-cache -fv

# setup starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

# clone zsh setup
WORKDIR $HOME
RUN git clone https://github.com/silversurfer98/zsh_setup


# copy configs
RUN cp -R $HOME/zsh_setup/.config $HOME && cp -R $HOME/zsh_setup/.zsh $HOME && cp $HOME/zsh_setup/.zshrc $HOME

# change to zsh
RUN sudo chsh -s $(which zsh)

# Run zsh on container start
CMD [ "zsh" ]

# keep container running
#CMD ["tail", "-f", "/dev/null"]
