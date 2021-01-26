FROM ubuntu:20.04

# workaround for some libraries requiring user interaction when installing (tzdata)
ARG DEBIAN_FRONTEND=noninteractive

# install prerequisites
RUN apt-get update -y
RUN apt-get install -y wget lame ffmpeg python3-pip unzip
RUN wget https://fkurz.net/ham/ebook2cw/ebook2cw -P /usr/local/bin && chmod +x /usr/local/bin/ebook2cw
RUN pip3 install boto3

# download the project and unpack zip
RUN wget https://github.com/sklegg/Morse-Code-Ninja/archive/main.zip -P /opt && cd /opt && unzip main.zip && mkdir cache

# alias python to python3
RUN ln -s /usr/bin/python3 /usr/bin/python