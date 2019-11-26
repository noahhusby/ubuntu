#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]

RUN apt-add-repository universe
RUN apt-get update
RUN apt-get install maven -y

RUN sudo add-apt-repository ppa:openjdk-r/ppa
RUN sudo apt-get update

RUN sudo apt-get install openjdk-8-jdk -y

RUN sudo rm -rf /usr/lib/jvm/java-1.7.0-openjdk-amd64 && \
  sudo rm -rf java-7-openjdk-amd64

RUN git clone https://github.com/devgianlu/PYX-Reloaded.git
RUN \
  cd PYX-Reloaded && \
  sudo mvn clean package && \
  sudo javac -jar $HOME/PYX-Reloaded/target/PYX-Reloaded-jar-with-dependencies.jar
  
CMD tail -f /dev/null
