#!/bin/bash

logger "Activity Hound"

# Find if there's a console user or not. Blank return if not.
consoleuser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# Checks the LaunchAGENT

logger "Checking for LaunchAgent presence."

laloc="/Library/LaunchAgents/com.activity_hound.plist"
if [ -f "$laloc" ];
then
	/usr/bin/sudo -iu "$consoleuser" launchctl load "$laloc"
else
	logger "Not found"
fi

logger "Install complete. Please check status."
