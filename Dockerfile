FROM ubuntu:20.04

RUN apt-get update -y
RUN apt-get install -y wget lame ffmpeg python3-pip
RUN wget https://fkurz.net/ham/ebook2cw/ebook2cw
# add ebook2cw to PATH?
RUN pip install boto3
