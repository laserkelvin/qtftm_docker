#!/bin/bash

# Bash script to spin up the qtftm docker image, and run QtFTM.
# The DISPLAY variable ensures that the Qt application is actually passing
# the X11 client to the "real" machine.
# The -v flag mounts the /home/data/QtFTM folder into the container instance.
# The -d flag makes the container run in the background, but will stop as soon
# as QtFTM is exited
# The --rm flag will remove the container after it is stopped

# This sets up the DISPLAY properly
export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $IP

docker run \
    --rm \
    --privileged \
    -e DISPLAY=$IP:0 \
    -e LD_LIBRARY_PATH=/usr/local/qwt6/lib \
    qtftm \
    qtftm
    #-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    #-v /home/data:/home/data:rw \
    #-v /dev:/dev \
