FROM ubuntu:latest
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt update
RUN apt install -y curl wget

#h python3-boto3 git


RUN apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget --yes


RUN mkdir -p /tmp/python

WORKDIR /tmp/python
RUN wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tgz
RUN tar -xvf Python-3.10.11.tgz

Workdir /tmp/python/Python-3.10.11


RUN ./configure --enable-optimitations
RUN make install

WORKDIR /

RUN apt install python3-pip --yes
RUN apt install python3-boto3 --yes
RUN apt install git --yes


RUN pip  install ansible==7.5.0
RUN pip  install requests
RUN apt install sshpass --yes

# Select Scripts for installation here
RUN ansible-galaxy collection install community.general
RUN ansible-galaxy collection install community.docker



# Install Semaphore
RUN wget https://github.com/ansible-semaphore/semaphore/releases/download/v2.8.75/semaphore_2.8.75_linux_amd64.deb
RUN dpkg -i semaphore_2.8.75_linux_amd64.deb

# Install Scripts
COPY var/scripts/wait-for-it.sh /
RUN chmod +x /wait-for-it.sh

COPY var/scripts/semaphore-start.sh /
RUN chmod +x /semaphore-start.sh

COPY var/scripts/installOnClient.sh /
RUN chmod +x /installOnClient.sh


CMD ["./wait-for-it.sh" , "ansible-sql:3306" , "--strict" , "--timeout=300" , "--", "bin/sh","/semaphore-start.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]


