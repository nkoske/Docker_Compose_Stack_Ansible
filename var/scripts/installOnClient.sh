echo "your Ansible needs SSH activated in order to run this Script"

echo "Ip Address:"
ipaddr=$IP_ADDRESS

echo "User:"
usr=$USER

echo "Homedir:"
home=$HOME_DIR

echo "Password:"
passwd=$PASSWORD

remoteOsRelease=$(sshpass -p $passwd ssh -o StrictHostKeyChecking=no ${usr}@${ipaddr} 'cat /etc/os-release 2>&1')
os_name=$(echo $remoteOsRelease | cut -f2 -d"\"" )

echo "---${os_name}--"


if [ "$os_name" = "Alpine Linux" ]; 
then
	echo "Alpine linux install Started"
	
	sshpass -p $passwd ssh -o "StrictHostKeyChecking no" $usr@$ipaddr "apk update && apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python && python3 -m ensurepip && pip3 install --no-cache --upgrade pip setuptools && pip3 install ansible && pip3 install collection && mkdir -p /root/.ssh/"
	
        sshpass -p $passwd scp /root/.ssh/id_rsa.pub $user@$ipaddr:$home/.ssh/authorized_keys        

fi


if [ "$os_name" = "Ubuntu" ]; 
then
	echo "Ubuntu install Started"
	sshpass -p $passwd ssh -o "StrictHostKeyChecking no" $usr@$ipaddr "apt update && apt install python3 --yes && ln -sf python3 /usr/bin/python  && apt install python3-pip --yes && pip3 install --no-cache --upgrade pip setuptools && pip3 install --no-cache --upgrade ansible && pip3 install --no-cache --upgrade collection"
		
fi

if [ "$os_name" = "Debian" ]; 
then
	echo "Debian install Started"
	sshpass -p $passwd ssh -o "StrictHostKeyChecking no" $usr@$ipaddr "apt update && apt install python3 --yes && ln -sf python3 /usr/bin/python  && apt install python3-pip --yes && pip3 install --no-cache --upgrade pip setuptools && pip3 install --no-cache --upgrade ansible && pip3 install --no-cache --upgrade collection"
		
fi
