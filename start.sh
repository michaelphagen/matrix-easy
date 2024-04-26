#!/bin/bash

echo "This script will automate the setup of a matrix server with bridges as a self-hosted version of beeper"


# Ask the user for the domain
echo "Enter the domain for the homeserver (e.g. example.com):"
read DOMAIN

docker run -it --rm \
    -v="$(pwd)"/synapse:/data \
    -e SYNAPSE_SERVER_NAME="${DOMAIN}" \
    -e SYNAPSE_REPORT_STATS=yes \
    matrixdotorg/synapse:latest generate

echo "Adding the mods to the homeserver.yaml"
# echo synapse/homeserver-mods.txt into homeserver.yaml
cat synapse/homeserver-mods.txt >> synapse/homeserver.yaml

echo "Generating shared secret for the homeserver"
# Generate shared secret using docker container
SHARED_SECRET=$(docker run --rm sofianinho/pwgen-alpine -s 128 1)
# Replace the shared secret and domain in config files
find ./synapse -type f -exec sed -i -e "s/longsharedsecret_to_be_replaced/$SHARED_SECRET/g" -e "s/template_domain.to.replace/$DOMAIN/g" {} \;
find ./bridges -type f -exec sed -i -e "s/longsharedsecret_to_be_replaced/$SHARED_SECRET/g" -e "s/template_domain.to.replace/$DOMAIN/g" {} \;
echo "Do you want to set up the iMessage Bridge? (Note, you will need a Mac to set this up) (y/n)"
read IMESSAGE

if [ "$IMESSAGE" = "y" ]; then
    echo "Setting up iMessage Bridge"
    # Replace the iMessage bridge setup script with the correct one
    ./imessage-setup.sh
else
    echo "Skipping iMessage Bridge setup"
fi

echo "Bringing up the bridge containers to generate registration.yaml files"
# Bring up containers so that they generate the registration.yaml files
docker-compose up -d bridge-twitter bridge-discord bridge-whatsapp bridge-gchat bridge-instagram bridge-linkedin bridge-messenger bridge-signal bridge-telegram bridge-slack bridge-sms bridge-irc
# Wait for the containers to generate the registration.yaml files
sleep 5
# Bring down the containers
docker-compose down

# Check that there is a registration.yaml file for each bridge (sometimes the bridges fail to generate the file or generate a directory instead)
echo "Checking for registration.yaml files"
# Check that there is a registration.yaml file (not directory) for each bridge
# If there is a directory, delete it and bring up the bridge again
find ./bridges -name registration.yaml | while IFS= read -r f; do
    if [ -d "$f" ]; then
        echo "Deleting directory $f"
        rm -r "$f"
        # Bring up the docker container called bridge-<name> again
        BRIDGE_NAME=$(echo "$f" | cut -d'/' -f3)
        echo "Bringing up $BRIDGE_NAME"
        docker-compose up -d "bridge-$BRIDGE_NAME"
    fi
done


echo "Making registration.yaml files readable"
# Make all SERVICE_FOLDER/registration.yaml files readable
find ./bridges -name registration.yaml | while IFS= read -r f; do
    chmod 644 "$f"
done

echo "Fixing linkedin permissions"
# Fix linkedin permissions
chmod 777 -R ./bridges/linkedin

echo "Fixing synapse permissions"
chmod 777 -R ./synapse

echo "Starting homeserver for user registration"
docker-compose up -d synapse
echo "Enter your user details below"
docker exec -it synapse register_new_matrix_user -c /data/homeserver.yaml http://localhost:8008

# If the user wants to set up the iMessage bridge, they should start the bridge now
if [ "$IMESSAGE" = "y" ]; then
    echo "On your Mac, cd into the bridges/imessage folder and run ./mautrix-imessage"
    echo "If everything works, you can install the bridge by running ./install.sh"
    echo "Once you have started the bridge, press enter to continue"
    read CONTINUE
fi

docker-compose down
echo "Starting all services"
docker-compose up -d

echo "Setup complete. You can now access your homeserver at http://$DOMAIN:8008"