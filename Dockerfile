#
# $ docker build -t borud/kerlink-build .
#
FROM ubuntu
MAINTAINER borud@telenordigital

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install gcc-arm-linux-gnueabi
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install make
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install autoconf
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install curl

ENV TARGETMACH=arm-linux-gnueabi
ENV BUILDMACH=i686-pc-linux-gnu
ENV CROSS=arm-linux-gnueabi
ENV CC=${CROSS}-gcc
ENV LD=${CROSS}-ld
ENV AS=${CROSS}-as
ENV CROSS_DIR=/usr/local/cross


# Set up the build environment
RUN printf "\nexport TARGETMACH=arm-linux-gnueabi\nexport BUILDMACH=i686-pc-linux-gnu\nexport CROSS=arm-linux-gnueabi\nexport CC=${CROSS}-gcc\nexport LD=${CROSS}-ld\nexport AS=${CROSS}-as\nexport=CROSS_DIR=/usr/local/cross\n" >> /etc/profile

# Build zlib
RUN cd $HOME && curl -O http://zlib.net/zlib-1.2.8.tar.gz && tar xvfz zlib-1.2.8.tar.gz && cd zlib-1.2.8 && ./configure --static --prefix=$CROSS_DIR && make install

# Build OpenSSL
RUN cd $HOME && curl -O curl -O https://www.openssl.org/source/openssl-1.0.2d.tar.gz && tar xvf openssl-1.0.2d.tar.gz
RUN cd $HOME/openssl-1.0.2d && ./Configure --target=arm-linux linux-generic32 shared -DL_ENDIAN --prefix=$CROSS_DIR --openssldir=$CROSS_DIR && make install
