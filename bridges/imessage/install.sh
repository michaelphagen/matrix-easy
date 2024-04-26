#!/bin/bash
# Installs the iMessage bridge

# Put this folder into ~/Library/imessage-bridge
# This is the folder that the iMessage bridge will use to store its data and executable
sudo cp -r . /Library/imessage-bridge
sudo chmod -R 777 /Library/imessage-bridge

# Put the launchagent plist file into ~/Library/LaunchAgents
# This will start the iMessage bridge on boot
cp ./imessage-bridge.plist ~/Library/LaunchAgents