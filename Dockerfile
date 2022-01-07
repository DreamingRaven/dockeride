FROM alpine:edge

# alpine sdk and neovim come with LuaJIT no need to add it ourselves
# setup the basic system
RUN apk add --update \
    git \
    nodejs \
    neovim \
    ripgrep \
    alpine-sdk \
    xclip \
    python3 \
    nodejs \
    neovim-doc \
    rust \
    tree

# setting config destination dir
ARG NEOVIM_CONFIG_DIR="/root/.config/nvim"
ARG PLAYGROUND_DIR="/root/playground"

# ensure neovim config dir exists and code-minimap is installed
RUN mkdir -p ${NEOVIM_CONFIG_DIR} && \
    mkdir -p ${PLAYGROUND_DIR} && \
    ln -s ${PLAYGROUND_DIR} /playground \
    cargo install code-minimap


# use ours or direct nvchad config
COPY . ${NEOVIM_CONFIG_DIR}
# RUN git clone https://github.com/NvChad/NvChad ${NEOVIM_CONFIG_DIR}

# helpful debug info to see what is there
RUN tree ${NEOVIM_CONFIG_DIR}

# Bootstrap packer https://github.com/wbthomason/packer.nvim#bootstrapping
# https://github.com/wbthomason/packer.nvim/issues/599
# has some workaround in https://github.com/qwelyt/docker-stuff/commit/a41c2275e2311d3f6a5d53f7c4001999cd5005dd
# alternativeley we can just use silent to skip the prompt ...
# https://stackoverflow.com/questions/890802/how-do-i-disable-the-press-enter-or-type-command-to-continue-prompt-in-vim
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'silent PackerSync'

# set up working directory and entrypoint
WORKDIR /root
ENTRYPOINT nvim '+set clipboard=unnamed'
