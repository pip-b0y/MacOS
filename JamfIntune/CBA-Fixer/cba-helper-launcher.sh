#!/bin/bash
#JAMF-AAD-ADFS-Certhelper-Launcher-MK-3
logger "JAMF-AAD-ADFS-Certhelper"
# Find if there's a console user or not. Blank return if not.
consoleuser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# Make sure plist is there
logger "Checking for LaunchAgent presence."
laloc="/Library/LaunchAgents/com.jamf-aad-agent.pre-adfs-cba.plist"
if [ -f "$laloc" ];
then

#kill then revive
launchctl unload "$laloc"
launchctl load "$laloc"
echo "Success We should be good to go"
else
logger "Not found"
echo "Failed"
fi
logger "Install complete. Please check status."
exit 0
