DockerIDE
=========

DockerIDE is a derivative of NvChad that further customises, and packages NvChad in an isolated container.

I always wanted an IDE that I could easily modify like neovim but I never liked the security vulnerabilities that can come with using a plethora of plugins. It only takes but one to go rogue, and if I was not paying attention, that could cause problems.
DockerIDE seeks to solve this by containerising the whole of Neovim and its plugins into a unprivileged container. That way only the files I allow could possibly be modified, and all the other processes are isolated from both my normal workspace, and from other running processes.

I also wanted an IDE that was not only customable but reproducible across any and all of my systems. Its not great having these customisations but then having trying to reproduce them on other machines. So lets use docker containers we can build and distribute, and that other can build on top of!
