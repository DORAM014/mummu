#LXC Fun
#
#
#Version 0.01
FROM ubuntu

#Maintainer 

MAINTAINER Michael Doran michael.doran.808@gmail.com

RUN mv /etc/apt/sources.list /etc/apt/sources.back 
RUN touch /etc/apt/sources.new 
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt precise main" >> /etc/apt/sources.new 
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt precise-updates main" >> /etc/apt/sources.new
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt precise-backports main" >> /etc/apt/sources.new
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt precise-security main" >> /etc/apt/sources.new
RUN cat /etc/apt/sources.new /etc/apt/sources.bak > /etc/apt/sources.list

RUN sed -i 's/precise/saucy/' /etc/apt/sources.list
RUN sed -i 's/archive.ubuntu.com/ragana.canonical.com/'
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN apt-get -y install wget
RUN mkdir /opt
RUN cd /opt && wget https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz
RUN tar -xvf protobuf-2.5.0.tar.gz && cd /opt/protobuf-2.5.0
RUN autoreconf --force && ./autogen.sh && ./configure && make && make install

RUN apt-get -y install libjemalloc-dev

RUN apt-get -y install libboost-all-dev

RUN apt-get -y install git


RUN apt-get -y install python-software-properties
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN apt-get -y install make autoconf automake libtool
RUN apt-get -y install gcc-4.8 g++-4.8 
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50


RUN cd /opt && git clone https://github.com/keithw/remy.git

RUN cd /opt/remy && autoreconf --force && ./autogen.sh && ./configure && make && make install
