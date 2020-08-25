#!/bin/bash
#lets check to see if the Agent is installed
laloc="/Library/LaunchAgents/com.jamf-aad-agent.pre-adfs-cba.plist"
if [ -f "$laloc" ];
then
echo "https://$4/adfs/ls" >> /Library/Application\ Support/JAMFAAD/adfs1
echo "https://$4/adfs/ls/" >> /Library/Application\ Support/JAMFAAD/adfs2
ehco "It has been created. Agent is set up ready for activation"
else
echo "We are closing this Install the CBA-Helper."
fi
exit 0

