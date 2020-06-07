FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && apt-get install -y \
#     software-properties-common

# RUN add-apt-repository universe

RUN \
apt-get update && \
apt-get install --no-install-recommends -y \
curl \
libguestfs-tools \
qemu-utils \
unzip \
ca-certificates \
git \
python-pip \
python-setuptools \ 
python-dev \
wget \
tmux \
vim \
gnupg \
apt-transport-https \
# Import the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
# Register the Microsoft Product feed
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list' \
# Install PowerShell
powershell \
# wget \
# wget https://github.com/PowerShell/PowerShell/releases/download/v7.0.1/powershell-lts_7.0.1-1.debian.11_amd64.deb \  
# apt install powershell-lts_7.0.1-1.debian.11_amd64.deb \
# apt-get install -f \
# wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb && \
# apt-get install /tmp/packages-microsoft-prod.deb && \
# apt-get update && \
# apt-get install -y \
# powershell && \  
# apt-transport-https \
# curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
# sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list'
build-essential


RUN pip install python-openstackclient ansible shade dnspython awscli s3cmd 

##download and install powershell
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb 
RUN apt-get install /tmp/packages-microsoft-prod.deb && \
apt-get update && \
apt-get install -y \
powershell 

###download and install terraform
##this command is for version 12 of terraform
RUN wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip -O /tmp/terraform.zip && \
##this command is for version 11 of terraform
#RUN wget https://releases.hashicorp.com/terraform/0.11.2/terraform_0.11.2_linux_amd64.zip -O /tmp/terraform.zip && \
unzip /tmp/terraform.zip -d /usr/local/bin/ && \
chmod a+x /usr/local/bin/terraform

VOLUME ~/.ssh/
VOLUME /opt/scripts

WORKDIR /opt/scripts

ENTRYPOINT /bin/bash 