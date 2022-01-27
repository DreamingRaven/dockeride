DockerIDE
=========

DockerIDE is a derivative of NvChad that further customises, and packages NvChad in an isolated container.

I always wanted an IDE that I could easily modify like neovim but I never liked the security vulnerabilities that can come with using a plethora of plugins. It only takes but one to go rogue, and if I was not paying attention, that could cause problems.
DockerIDE seeks to solve this by containerising the whole of Neovim and its plugins into a unprivileged container. That way only the files I allow could possibly be modified, and all the other processes are isolated from both my normal workspace, and from other running processes.

I also wanted an IDE that was not only customable but reproducible across any and all of my systems. Its not great having these customisations but then having trying to reproduce them on other machines. So lets use docker containers we can build and distribute, and that other can build on top of!

Requirements
++++++++++++

This project requires only one thing. `Docker <https://docs.docker.com/>`_ .
Make sure Docker is installed and the Docker daemon is running.

Quick Start
+++++++++++

If you just want to try it out:

.. code-block::

  sudo docker run -it registry.gitlab.com/deepcypher/dockeride:master

This will be just the default installation, there wont be any files or folders mounted inside this container. So feel free to play around with wanton disregard.

Usage
+++++

Clearly an IDE has no purpose unless you can modify desired files in a persistent manner. To do this we need only mount the files we desire using docker mounts.

E.G if you have downloaded this git repo and are currentley in the same directory as this README, you can use DockerIDE to modify itself (we use the folder /home/archer/git/dockeride your dockeride may be somewhere else or if you want to modify other files simply change this path to a directory you want to use) by:

.. code-block::

  sudo docker run --volume /home/archer/git/dockeride:/playground -it registry.gitlab.com/deepcypher/dockeride:master

If you would like to build the docker container and run it yourself so you can have your own customisations you can use:

.. code-block::

  sudo docker build -t a/dockeride -f Dockerfile . && sudo docker run --volume /home/archer/git/dockeride:/playground -it a/dockeride

playground is a symlink that will ensure the files are read-writeable and mounted in the correct location, for the correct user. The intention is to drop permissions so the user can only modify the selected files and cant modify the container in any consequential way.

Lastly the clipboard. Neovim uses clipboard providers to allow it to access the clipboard. (use ':help provider-clipboard' and ':checkhealth' to verify a valid provider exists for the clipboard). The provider is selected based on the ${DISPLAY} environment variable. So for instance on X11 ${DISPLAY} might be ':0' which would select 'xclip' or some other valid X11 provider. So in some ways it is possible to just share this environment variable in the container, which does work once, before clipboard errors. However if you want to make it more repeatable you can share X11 with the container and set it as valid in xhost:

.. code-block::

  xhost local:root && \
  sudo docker build -t a/dockeride -f Dockerfile . && \
  sudo docker run -e DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix --volume /home/archer/git/dockeride:/playground -it a/dockeride
  # xhost -local:root # uncomment this to remove local root from authenticatable hosts again

There is not much information on this but you can refer to: https://stackoverflow.com/a/41703217/11164973

NvChad
++++++

NvChad has some decent documentation that of course still applies here: https://nvchad.github.io/getting-started/post-install DockerIDE should be almost 1-1 with NvChad. We only recustomise and add some extra goodness. However if you have any issues, please report it here first. We dont want to spam NvChad with issues that may or may not relate to it. We suspect most issues will be docker related, since its quite a rigid/ constrained way to run things.
