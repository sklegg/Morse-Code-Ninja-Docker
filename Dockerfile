FROM ubuntu:20.04

# workaround for some libraries requiring user interaction when installing (tzdata)
ARG DEBIAN_FRONTEND=noninteractive

# install prerequisites
RUN apt-get update -y --fix-missing
RUN apt-get install -y wget lame ffmpeg python3-pip unzip make cpanminus nodejs npm
RUN wget https://fkurz.net/ham/ebook2cw/ebook2cw -P /usr/local/bin && chmod +x /usr/local/bin/ebook2cw
RUN pip3 install boto3

# install some perl libraries
RUN cpanm Log::Log4perl Getopt::Long Getopt::ArgvFile

# make our install directory
RUN mkdir /opt/ninja && mkdir /opt/ninja/cache

# download the project and unpack zip
RUN wget https://github.com/sklegg/Morse-Code-Ninja/archive/main.zip -P /tmp && cd /tmp && unzip main.zip && mv Morse-Code-Ninja-main/* /opt/ninja/

# download the site project
RUN wget https://github.com/sklegg/Morse-Code-Ninja-Site/archive/master.zip -P /tmp && cd /tmp && unzip master.zip && mv Morse-Code-Ninja-Site-master/* /opt/ninja/

# alias python to python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# install the express framework
RUN npm install express

# run the site server
# CMD ["node", "/opt/ninja/app/app.js"]