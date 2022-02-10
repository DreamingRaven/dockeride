#!/usr/bin/env bash

full_path=$(realpath $0)
# echo $full_path
dir_path=$(dirname $full_path)
# echo $dir_path
cd "${dir_path}"

# this gives root the permissions necessary to access our X11 file
# clearly not suitable for anything other than X11
xhost local:root

# build and run our container, editing its own files
sudo docker build -t a/dockeride -f Dockerfile . && \
  sudo docker run -e DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix --volume ${dir_path}:/playground -it a/dockeride
