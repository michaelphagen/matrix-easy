#!/bin/bash

# Uncomment #- /app_services/imessage-registration.yaml in synapse/homeserver.yaml
sed -i -e 's/#- \/app_services\/imessage-registration.yaml/- \/app_services\/imessage-registration.yaml/g' synapse/homeserver.yaml
# Uncomment #- ./bridges/imessage/registration.yaml:/app_services/imessage-registration.yaml in docker-compose.yml
sed -i -e 's/#- .\/bridges\/imessage\/registration.yaml:\/app_services\/imessage-registration.yaml/- .\/bridges\/imessage\/registration.yaml:\/app_services\/imessage-registration.yaml/g' docker-compose.yml
echo "Please enter the IP of the homeserver"
read HOMESERVER_IP
# Replace homeserver_ip in bridges/imessage/config.yaml
sed -i -e "s/homeserver_ip: \"\"/homeserver_ip: \"$HOMESERVER_IP\"/g" bridges/imessage/config.yaml

echo "Please enter the ip of the mac running the bridge"
read BRIDGE_IP
# Replace mac.ip.template.to.replace in bridges/imessage/config.yaml
sed -i -e "s/mac.ip.template.to.replace: \"\"/mac.ip.template.to.replace: \"$BRIDGE_IP\"/g" bridges/imessage/config.yaml

# Replace bluebubbles_url_to_be_replaced in bridges/imessage/config.yaml
echo "Please enter the URL:PORT of the BlueBubbles server"
read BLUEBUBBLES_URL
sed -i -e "s/bluebubbles_url_to_be_replaced: \"\"/bluebubbles_url_to_be_replaced: \"$BLUEBUBBLES_URL\"/g" bridges/imessage/config.yaml

# Replace bluebubbles_pw_to_be_replaced in bridges/imessage/config.yaml
echo "Please enter the password for the BlueBubbles server"
read BLUEBUBBLES_PW
sed -i -e "s/bluebubbles_pw_to_be_replaced: \"\"/bluebubbles_pw_to_be_replaced: \"$BLUEBUBBLES_PW\"/g" bridges/imessage/config.yaml

echo "Config files have been updated"
echo "Please copy the bridges/imessage folder to a Mac, open terminal, cd into the folder and run ./mautrix-imessage -g"
echo "This will generate the registration file, which you will need to copy back to the bridges/imessage folder"
echo "Once you are done, press enter to continue"
read CONTINUE
