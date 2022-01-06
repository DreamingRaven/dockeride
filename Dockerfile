FROM alpine:edge

# alpine sdk and neovim come with LuaJIT no need to add it ourselves
# ARG LUA_VER="5.4"
# ARG LUA_PKG="lua${LUA_VER}"
# ARG LUA_EXEC="${LUA_PKG}"

# setup the basic system
RUN apk add --update \
    git \
    nodejs \
    neovim \
    ripgrep \
    alpine-sdk \
    tree
    # ${LUA_PKG} \

# setting config destination dir
ARG NEOVIM_CONFIG_DIR="/root/.config/nvim"

# setup neovim configuration and plugins
RUN mkdir -p ${NEOVIM_CONFIG_DIR}
COPY . ${NEOVIM_CONFIG_DIR}
# RUN git clone https://github.com/NvChad/NvChad ${NEOVIM_CONFIG_DIR}
RUN tree ${NEOVIM_CONFIG_DIR}

# Bootstrap packer https://github.com/wbthomason/packer.nvim#bootstrapping
# https://github.com/wbthomason/packer.nvim/issues/599
# has some workaround in https://github.com/qwelyt/docker-stuff/commit/a41c2275e2311d3f6a5d53f7c4001999cd5005dd
# RUN cd /root/.config/nvim/ && \
#     ${LUA_EXEC} ./init.lua
# RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# set up working directory and entrypoint
WORKDIR /root
# ENTRYPOINT nvim
