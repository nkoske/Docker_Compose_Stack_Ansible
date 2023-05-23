
    configpath=/config
    configString="${SEMAPHORE_DB_TYPE}\n${SEMAPHORE_DB_HOSTNAME}\n${SEMAPHORE_DB_USER}\n${SEMAPHORE_DB_PASS}\n${SEMAPHORE_DB_NAME}\n${SEMAPHORE_PLAYBOOK_PATH}\n\n\n\n\n\n${configpath}\n${SEMAPHORE_UI_USERNAME}\n${SEMAPHORE_UI_EMAIL}\n${SEMAPHORE_UI_NAME}\n${SEMAPHORE_UI_PASSWORD}\n\n"
    
if [[ "$*" == *"--force-config"* ]]; 
then
	  printf ${configString} | semaphore setup
else
	if [ ! -f "/config/config.json" ]; then
		printf ${configString} | semaphore setup
	fi
	
	if [ ! -f "/root/.ssh/id_rsa" ]; then
		
		echo "GENERATING SSH KEYS"
		printf "/root/.ssh/id_rsa\n${SSH_KEY_PASSPHRASE}\n${SSH_KEY_PASSPHRASE}\n" | ssh-keygen -t rsa -b 4096 -C "${SEMAPHORE_UI_EMAIL}"
	fi

	semaphore service --config=/config/config.json

fi







	

