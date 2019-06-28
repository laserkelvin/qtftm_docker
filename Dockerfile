# Disco Dingo has the newer version of Qt available on apt
FROM ubuntu:19.04
MAINTAINER Kelvin Lee (kinlee@cfa.harvard.edu)
RUN apt update
# Set up environment variables for installations
# This bit is necessary otherwise tzdata will halt the installation
ARG DEBIAN_FRONTEND=noninteractive
# This ensures a set path for qwt
ARG LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/include/qwt6
ARG LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/qwt6/lib
RUN apt install -y qt5-default \
    qttools5-dev \
    libqt5designer5 \
    libqt5svg5* \
    libqt5serialport5 \
    libqt5serialport5-dev \
    libnlopt-dev \
    libnlopt-cxx-dev \
    libboost-all-dev \
    git \
    build-essential \
    libeigen3-dev \
    libgsl-dev \
    libusb-1.0.0-dev \
    libudev-dev \
    wget \
    subversion \
    neovim \
    nano \
    x11-apps
# Set up the labjack drivers
RUN cd /tmp && \
    wget https://labjack.com/sites/default/files/software/exodriver-master.zip && \
    unzip exodriver-master.zip && \
    cd exodriver-master && \
    sh install.sh; exit 0
# Set up qwt
RUN cd /tmp && \
    svn export svn://svn.code.sf.net/p/qwt/code/branches/qwt-6.1 && \
    cd qwt-6.1 && \
    # This is a funky overwrite of the install prefix, which is hardcoded
    # this will install qwt6 to /usr/local/qwt6
    sed -i 's/-$$QWT_VERSION-svn/6/g' qwtconfig.pri && \
    sed -i 's/QWT_CONFIG     += QwtDesigner/#QWT_CONFIG     += QwtDesigner/g' qwtconfig.pri && \
    qmake qwt.pro && \
    make -j4 && \
    make install && \
    ln -s /usr/local/qwt6/include /usr/local/include/qwt6
# Prepare to set up QtFTM
RUN git clone https://github.com/kncrabtree/qtftm.git /tmp/qtftm && \
    cd /tmp/qtftm
COPY config.pri /tmp/qtftm/config.pri
RUN cd /tmp/qtftm && \
    qmake QtFTM.pro && \
    make -j4; exit 0
RUN ln -s /tmp/qtftm/qtftm /usr/local/bin/qtftm

