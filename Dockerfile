FROM alpine:edge

# user related args
ARG USERNAME="archie"
ARG NEOVIM_CONFIG_DIR=".config/nvim"
ARG PLAYGROUND_DIR="playground"

# alpine sdk and neovim come with LuaJIT no need to add it ourselves
# setup the basic system
RUN apk add --update \
    git \
    nodejs \
    neovim \
    ripgrep \
    alpine-sdk \
    xclip \
    neovim-doc \
    tree \
    shadow

# RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
# language dependencies, and language servers for things like CoC
RUN apk add --repository "https://dl-cdn.alpinelinux.org/alpine/edge/testing" \
    go \
    gopls \
    rust \
    cargo \
    npm && \
    npm install -g dockerfile-language-server-nodejs

# create and swap to user to drop privs
RUN useradd -m ${USERNAME} && \
    ln -s /home/${USERNAME}/${PLAYGROUND_DIR} /playground && \
    chown -R ${USERNAME}:${USERNAME} /playground
USER ${USERNAME}

# ensure neovim config dir exists and code-minimap is installed
RUN mkdir -p ${HOME}/${NEOVIM_CONFIG_DIR} && \
    mkdir -p ${HOME}/${PLAYGROUND_DIR}

# set up working directory and entrypoint
WORKDIR ${HOME}/${PLAYGROUND_DIR}

# set cargo path into users bashrc
RUN echo "export PATH=${HOME}/.cargo/bin" >> ${HOME}/.bashrc

# use ours or direct nvchad config
COPY . "/home/${USERNAME}/${NEOVIM_CONFIG_DIR}"
# RUN git clone https://github.com/NvChad/NvChad ${NEOVIM_CONFIG_DIR}

# helpful debug info to see what is there
RUN tree "${HOME}/${NEOVIM_CONFIG_DIR}"

# Bootstrap packer https://github.com/wbthomason/packer.nvim#bootstrapping
# https://github.com/wbthomason/packer.nvim/issues/599
# has some workaround in https://github.com/qwelyt/docker-stuff/commit/a41c2275e2311d3f6a5d53f7c4001999cd5005dd
# alternativeley we can just use silent to skip the prompt ...
# https://stackoverflow.com/questions/890802/how-do-i-disable-the-press-enter-or-type-command-to-continue-prompt-in-vim
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'silent PackerSync'

#ENTRYPOINT nvim '+set clipboard=unnamed'
CMD nvim '+set clipboard=unnamed'
