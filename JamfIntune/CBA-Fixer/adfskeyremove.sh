#!/bin/bash

#Varibles
adfs1=$(cat /Library/Application\ Support/JAMFAAD/adfs1)
adfs2=$(cat /Library/Application\ Support/JAMFAAD/adfs2)
currentuser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
date1=$(date +%Y-%m-%d_%H:%M:%S)


echo "$date1 targeting $currentuser removing unwanted items in the keychain from CompanyPortal" >> /tmp/jamfaad-preadfs-auth.log
echo "$date1 key $adfs1 will be removed" >> /tmp/jamfaad-preadfs-auth.log
echo "$date1 key $adfs2 will be removed" >> /tmp/jamfaad-preadfs-auth.log
/usr/bin/sudo -iu $currentuser /usr/bin/security find-generic-password -s "$adfs2" keychain "/Users/${currentuser}/Library/Keychains/login.keychain-db"
/usr/bin/sudo -iu $currentuser /usr/bin/security find-generic-password -s "$adfs2" keychain "/Users/${currentuser}/Library/Keychains/login.keychain-db"

#Workload
echo "$date1 results of the job:" >> /tmp/jamfaad-preadfs-auth.log
/usr/bin/sudo -iu $currentuser security delete-generic-password -s "$adfs1" keychain "/Users/$currentuser/Library/Keychains/login.keychain"
/usr/bin/sudo -iu $currentuser security delete-generic-password -s "$adfs2" keychain "/Users/$currentuser/Library/Keychains/login.keychain"
echo "Job End" >> /tmp/jamfaad-preadfs-auth.log
echo "$date1 keys should be removed from keychain." >> /tmp/jamfaad-preadfs-auth.log
exit 0

