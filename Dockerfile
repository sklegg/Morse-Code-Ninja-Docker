FROM ubuntu:20.04

# workaround for some libraries requiring user interaction when installing (tzdata)
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get install -y wget lame ffmpeg python3-pip
RUN wget https://fkurz.net/ham/ebook2cw/ebook2cw -P /usr/local/bin && chmod +x /usr/local/bin/ebook2cw
RUN pip3 install boto3