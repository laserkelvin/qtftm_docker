#!/bin/bash

# Bash script to spin up the qtftm docker image, and run QtFTM.
# The DISPLAY variable ensures that the Qt application is actually passing
# the X11 client to the "real" machine.
# The -v flag mounts the /home/data/QtFTM folder into the container instance.
# The -d flag makes the container run in the background, but will stop as soon
# as QtFTM is exited
# The --rm flag will remove the container after it is stopped

#ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

docker run \
    --rm \
    --privileged \
    -e DISPLAY=docker.for.mac.host.internal:0 \
    -e LD_LIBRARY_PATH=/usr/local/qwt6/lib \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /home/data:/home/data:rw \
    -v /dev:/dev \
    # This is the container qtftm
    qtftm \
    # This is the binary qtftm
    qtftm
