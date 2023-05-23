echo "your Ansible needs SSH activated in order to run this Script"

echo "Ip Address:"
#read ipaddr
ipaddr="192.168.10.31"
echo "User:"
#read usr
usr=root

echo "Homedir:"
#read home
home=/root
echo "Password:"
#read passwd
echo "........"
passwd=Chicha34712


remoteOsRelease=$(sshpass -p $passwd ssh -o StrictHostKeyChecking=no ${usr}@${ipaddr} 'cat /etc/os-release 2>&1')
os_name=$(echo $remoteOsRelease | cut -f2 -d"\"" )

echo "---${os_name}--"


if [ "$os_name" = "Alpine Linux" ]; 
then
	echo "Alpine linux install Started"
	
	sshpass -p $passwd ssh -o "StrictHostKeyChecking no" $usr@$ipaddr "apk update && apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python && python3 -m ensurepip && pip3 install --no-cache --upgrade pip setuptools && pip3 install ansible && pip3 install collection"

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
