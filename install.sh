#!/bin/bash

set -e

PYTHON_VERSION=3.10
TIMEZONE=Europe/London
APT_PACKAGES="git \
              neovim \
              curl \
              wget \
              software-properties-common"

PYTHON=python$PYTHON_VERSION
PIP=pip$PYTHON_VERSION

# Set the timezone
ln -fs /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Install packages
apt-get update
apt-get install -y $APT_PACKAGES

# Install docker if not already installed
[ -x "$(command -v docker)" ] \
    || curl -fsSL https://get.docker.com | sh
    && usermod -aG docker $USER

# Install the Nvidia container runtime if not already installed
[ -x "$(command -v nvidia-container-runtime)" ] \
    || curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | apt-key add - \
    && distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
    && curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | tee /etc/apt/sources.list.d/nvidia-container-runtime.list \
    && apt-get update \
    && apt-get install -y nvidia-container-runtime

# Install python 3.9 and pip
[ -x "$(command -v $PYTHON)" ] \
    ||  add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y $PYTHON python3-pip

# To install Packer, the package manager, run:
#
# ```bash
# git clone --depth 1 https://github.com/wbthomason/packer.nvim\
#  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
#  ```
#
# Taken from [here](https://github.com/wbthomason/packer.nvim).
#
# Then, open `./lua/nlsfnr/packer.lua` in vim and run `:so` to install Packer,
# followed by `:PackerSync`. Notice that the `packer.lua` file is not loaded on
# startup.
DEST=$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
URL=https://github.com/wbthomason/packer.nvim

[ -d "$DEST" ] \
    || git clone --depth 1 $URL $DEST \
    && nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

unset DEST URL
