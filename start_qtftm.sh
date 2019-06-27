#!/bin/bash

# Bash script to spin up the qtftm docker image, and run QtFTM.
# The DISPLAY variable ensures that the Qt application is actually passing
# the X11 client to the "real" machine.
# The -v flag mounts the /home/data/QtFTM folder into the container instance.
# The -d flag makes the container run in the background, but will stop as soon
# as QtFTM is exited
# The --rm flag will remove the container after it is stopped

docker run -t qtftm \
    -d \
    --rm \
    --privileged \
    -e DISPLAY=$DISPLAY \
    #-v /home/data/QtFTM:/home/data/QtFTM:rw \
    #-v /dev:/dev \
    /tmp/qtftm/qtftm
