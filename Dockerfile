FROM ubuntu:22.10
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y python3-pip python-dev-is-python3 ssh python3-boto3 git
RUN pip  install ansible==7.5.0
RUN pip  install requests
RUN apt install sshpass --yes


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




