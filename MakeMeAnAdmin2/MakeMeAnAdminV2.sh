#!/bin/bash

#Script is taken from https://github.com/jamf/MakeMeAnAdmin/blob/master/MakeMeAnAdmin.sh
#Its been remixed
#you have to run the time requester FIRST
currentUser=$(who | awk '/console/{print $1}')
echo $currentUser
time_request=$(cat /Library/Application Support/JAMF/.time)


#Create the plist
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist Label -string "removeAdmin"

#Add program argument to have it run the update script
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist ProgramArguments -array -string /bin/sh -string "/Library/Application Support/JAMF/removeAdminRights.sh"

#Set the run inverval to run every 7 days
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist StartInterval -integer "${time_request}"

#Set run at load
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist RunAtLoad -boolean yes

#Set ownership
sudo chown root:wheel /Library/LaunchDaemons/removeAdmin.plist
sudo chmod 644 /Library/LaunchDaemons/removeAdmin.plist

#Load the daemon 
launchctl load /Library/LaunchDaemons/removeAdmin.plist
sleep 10

###RUN AT REBOOT AT ALL COSTS
sudo defaults write /Library/LaunchDaemons/removeAdminAtReboot.plist Label -string "removeAdminAtReboot"
#Add program argument to have it run the update script
sudo defaults write /Library/LaunchDaemons/removeAdminAtReboot.plist ProgramArguments -array -string /bin/sh -string "/Library/Application Support/JAMF/removeAdminRights.sh"
#Set the run inverval to run every 7 days
sudo defaults write /Library/LaunchDaemons/removeAdminAtReboot.plist StartInterval -integer 30
​
#Set run at load
sudo defaults write /Library/LaunchDaemons/removeAdminAtReboot.plist RunAtLoad -boolean yes
​
#Set ownership
sudo chown root:wheel /Library/LaunchDaemons/removeAdminAtReboot.plist
sudo chmod 644 /Library/LaunchDaemons/removeAdminAtReboot.plist



#########################
# make file for removal #
#########################

if [ ! -d /private/var/userToRemove ]; then
	mkdir /private/var/userToRemove
	echo $currentUser >> /private/var/userToRemove/user
	else
		echo $currentUser >> /private/var/userToRemove/user
fi

##################################
# give the user admin privileges #
##################################

/usr/sbin/dseditgroup -o edit -a $currentUser -t user admin

########################################
# write a script for the launch daemon #
# to run to demote the user back and   #
# then pull logs of what the user did. #
########################################

cat << 'EOF' > /Library/Application\ Support/JAMF/removeAdminRights.sh
if [[ -f /private/var/userToRemove/user ]]; then
	userToRemove=$(cat /private/var/userToRemove/user)
	echo "Removing $userToRemove's admin privileges"
	/usr/sbin/dseditgroup -o edit -d $userToRemove -t user admin
	rm -f /private/var/userToRemove/user
	launchctl unload /Library/LaunchDaemons/removeAdmin.plist
	rm /Library/LaunchDaemons/removeAdmin.plist
	log collect --last 30m --output /private/var/userToRemove/$userToRemove.logarchive
fi
EOF

exit 0
