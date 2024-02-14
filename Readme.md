# Docker_Compose_Stack_Ansible


## Installation
Cloning the Repository
```
git clone https://github.com/nkoske/Docker_Compose_Stack_Ansible.git
```

Copying the .env file
```
cd Docker_Compose_Stack_Ansible
cp .example.env .env
```
The .example.env is fully functional.
for prod environments it is advised to change usernames and passwords in the .env file






## Usage


Starting the Stack
```
docker-compose up -d
```

Generating the SSH Keypair for the ansible container (no password)
```
docker exec -it ansible /bin/bash
ssh-keygen
```

For Access to other Hosts copy the ansible pub key to the Worker node
```
 docker exec -it ansible /bin/bash
 ssh-copy-id -i /root/.ssh/id_rsa.pub root@[worker ip]
```
