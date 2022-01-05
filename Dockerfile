FROM alpine:latest

# setup the basic system
RUN apk add --update \
    git \
    nodejs \
    neovim \
    ripgrep \
    alpine-sdk \
    tree

# setup neovim configuration and plugins
RUN mkdir -p ~/.config/nvim
COPY . /root/.config/nvim
RUN tree ~/.config/nvim

# Bootstrap packer https://github.com/wbthomason/packer.nvim#bootstrapping
# https://github.com/wbthomason/packer.nvim/issues/599
# has some workaround in https://github.com/qwelyt/docker-stuff/commit/a41c2275e2311d3f6a5d53f7c4001999cd5005dd
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# set up working directory and entrypoint
WORKDIR /home/root
ENTRYPOINT nvim
