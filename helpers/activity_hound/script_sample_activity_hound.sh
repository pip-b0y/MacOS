#!/bin/bash
#Log out inactive user
#For Labs Only or shared desktops
#lynette Idel Time script
#mdm method doesnt close the open applications gracefully. So we need to deploy a plist (can be mdm controlled)
#Launch Agent is required
#IdelTimeSecs taken from https://www.jamf.com/jamf-nation/discussions/11807/force-logout-of-guest-user#responseChild67914 for time 30mins = 30x60 = 1800
#Plist
#<plist>
#<dict>
#<key>IdleTime</key>
#<integer>xxxx</integer>
#</dict>
#</plist>

#Varibles
IdleTimeSecs=$(expr $(ioreg -c IOHIDSystem | awk '/HIDIdleTime/{print $NF; exit}') / 1000000000)
prefdomain="com.auto-logout-inactive-user.plist"
preflocation="/Library/Managed Preferences/"
allowedIdleTime=$(defaults read "${preflocation}${prefdomain}" "IdleTime")
openedlistfile="/tmp/openapps.csv"
counter="1"
loggedInUser=$(stat -f%Su /dev/console)
loggedInUID=$(id -u "${loggedInUser}")
#Script-to-log-user-out
if [ "${IdleTimeSecs}" -ge "${allowedIdleTime}" ]; then
	echo "Time has expired starting log out"
	###When time is greater than what is in plist
	#Create a list of apps that are open
	/usr/bin/osascript -e 'tell application "System Events" to get name of (processes where background only is false)' > "${openedlistfile}"
	apps_open_count=$(head -1 "${openedlistfile}" | sed 's/[^,]//g' | wc -c)
	while [ "${counter}" -le "${apps_open_count}" ]
	do
		csv_place=$(cat "${openedlistfile}" | cut -d ',' -f"${counter}")
		echo ""${csv_place}" is open"
		killall ""${csv_place}""
		((counter++))
		done
		#Once all apps killed, Kill the login window
		launchctl bootout user/$(id -u ${loggedInUser})
	else
		echo "Idle Time is good"
	
	
	fi
