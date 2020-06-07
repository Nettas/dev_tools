FROM ubuntu:xenial

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl python-pip ruby wget jq snapd bash-completion apt-transport-https sudo gnupg2 unzip libguestfs-tools ca-certificates qemu-utils git tmux openssh-server vim software-properties-common && \
 #   curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
#RUN apt-get update && apt-get install -y software-properties-common python-pip python-setuptools python-dev curl ruby wget jq bash-completion apt-transport-https sudo gnupg2 unzip libguestfs-tools ca-certificates qemu-utils git tmux openssh-server vim software-properties-common build-essential && \
    ##installing k8s with signing key
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    ## adding k8s software repos
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install --no-install-recommends -y kubectl && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ && \
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    # wget -q https://xpra.org/gpg.asc -O- | sudo apt-key add - && \
    # add-apt-repository "deb https://xpra.org/ bionic main" && \
    # apt-get update && apt-get install --no-install-recommends -y xpra xpra-html5 firefox sakura icewm  && \
    #pip install ansible s3cmd awscli && \
    curl -s https://api.github.com/repos/kub#ernetes-sigs/aws-iam-authenticator/releases/latest | grep "browser_download.url.*linux_amd64" | cut -d : -f 2,3 | tr -d '"' | wget -O /usr/local/bin/aws-iam-authenticator -qi - && chmod 555 /usr/local/bin/aws-iam-authenticator && \
    curl -s https://api.github.com/repos/GoogleContainerTools/skaffold/releases/latest | grep "browser_download.url.*linux-amd64.$" | cut -d : -f 2,3 | tr -d '"' | wget -O /usr/local/bin/skaffold -qi - && chmod 555 /usr/local/bin/skaffold && \
    curl -sq https://storage.googleapis.com/kubernetes-helm/helm-v2.15.2-linux-amd64.tar.gz| tar zxvf - --strip-components=1 -C /usr/local/bin linux-amd64/helm && \
    curl -sq https://download.docker.com/linux/static/stable/x86_64/docker-18.09.9.tgz | tar zxvf - --strip-components=1 -C /usr/local/bin docker/docker && \
    rm -rf /var/lib/apt/lists/* && \
    # wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb && \
    # apt-get install /tmp/packages-microsoft-prod.deb && \
    # apt-get update && \
    # apt-get install -y \
    # powershell && \  
    wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip -O /tmp/terraform.zip && \
##this command is for version 11 of terraform
# #RUN wget https://releases.hashicorp.com/terraform/0.11.2/terraform_0.11.2_linux_amd64.zip -O /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin/ && \
    chmod a+x /usr/local/bin/terraform && \
    pip install python-openstackclient ansible shade dnspython s3cmd awscli  

#download and install powershell
# RUN sudo snap install powershell --classic
# RUN apt-get clean && apt-get update
# #wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb 
# RUN apt-get install /tmp/packages-microsoft-prod.deb && \
# apt-get update && \
# apt-get install -y \
# powershell 

VOLUME ~/.ssh/
VOLUME /opt/scripts

WORKDIR /opt/scripts 

ENTRYPOINT /bin/bash 