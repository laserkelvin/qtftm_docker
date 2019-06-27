# Docked QtFTM

This project is an attempt to make QtFTM distributable regardless of operating
system by utilizing docker containers. The Dockerfile uses an Ubuntu 19.04 image
(Disco Dingo), and grabs all of the necessary dependencies for building QtFTM.

## Instructions

First step is to install Docker for your operating system.

_Mac OSX_

Get the Docker graphical installer, which should come as a `.dmg` and `.app`.

_Ubuntu_

```
sudo apt install docker.io
```

With the Docker daemon running, we can build the QtFTM image:

```
docker build -t qtftm . | tee build.log
```

The `-t` flag will name the image `qtftm`, and the `tee` call will just send
all of the building output to file if anything should go wrong.

You should then be able to run the program by executing the `start_qtftm.sh`
script.

### The meaty steps

Now we have to incorporate machine/spectrometer settings.

__Why Ubuntu 19.04 and not an LTS?__

The earlier versions of Ubuntu will grab an earlier version of Qt 5.9 that
contains a pretty annoying printing bug, where previous settings are not stored.
This bug is patched in the later versions of Qt.

__Why Ubuntu?__

Because `apt` > `zypper`. On a more serious note, there is not particular reason
why; I just knew what libraries to install with `apt`. OpenSuse Leap would work
just as well.

