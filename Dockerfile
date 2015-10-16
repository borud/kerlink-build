#
# $ docker build -t borud/kerlink-build .
#
FROM ubuntu
MAINTAINER borud@telenordigital

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install gcc-arm-linux-gnueabi
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install make

# Set up the build environment
RUN printf "\n\nexport ARCH=arm\nexport CROSS_COMPILE=arm-linux-gnueabi-\n\n" >> /etc/profile

# Add a builder user
RUN useradd -ms /bin/bash builder
