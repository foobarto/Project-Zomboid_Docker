#!/usr/bin/env bash

# Check if both directory are writable
if [ ! -w /home/steam/Zomboid ]; then 
	echo "[Error] Can't access your data directory. Check permissions on your mapped directory with /home/steam/Zomboid."
	exit 1
fi

if [ ! -w /home/steam/projectzomboid ]; then 
	echo "[Error] Can't access your server files directory. Check permissions on your mapped directory with /home/steam/projectzomboid."
	exit 1
fi



echo -e "Update project zomboid..."
/home/steam/steamcmd/steamcmd.sh +login anonymous \
		+force_install_dir /home/steam/projectzomboid \
		+app_update 380870 \
		+quit

# Only change password is it doesn't exist
INIFILE="/home/steam/Zomboid/Server/${SERVERNAME}.ini"
sed -i -e s/RCONPassword=[[:space:]]/RCONPassword=${RCON_PASSWORD}/ $INIFILE



echo -e "Launching server..."
if [[ -z "${NOSTEAM}" ]]; then
  /home/steam/projectzomboid/start-server.sh -servername ${SERVERNAME} -steamport1 ${STEAMPORT1} -steamport2 ${STEAMPORT2} -adminpassword ${ADMINPASSWORD}
else
  /home/steam/projectzomboid/start-server.sh -servername ${SERVERNAME} -nosteam -steamport1 ${STEAMPORT1} -steamport2 ${STEAMPORT2} -adminpassword ${ADMINPASSWORD}
fi
