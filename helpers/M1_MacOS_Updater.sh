#!/bin/bash

#MacOS-M1-Updater##
#please use https://github.com/pip-b0y/Random_tools/blob/main/PasswordMash/PasswordMash_signed.dmg to generate the secure password values. $4 and $5 these values are hard set in Jamf Pro, while the salt is hard coded here in the script. Its an attempt to break up the flow of information 
###Password Masher Notes:
#$4 is the Encrypted String
#$5 is the Passphrase.
#Salt needs to be hard coded here
###Note:
#The user MUST be a Secure token user or this will not work at all. It is a must. You also must download and put the MacOS update somewhere on the device for this to work.
#Varibles
message="MacOS-M1-Updater: "
lapsuser="USERNAMEHERE" #LAPS User is the managed account with a secure token
salt="" #this is the salt value that gets generated from PasswordMasher
update_path="/path/to"
update_name="bigsur.app"
#Password Transform
secure_token_pass=$(echo "$4" | /usr/bin/openssl enc -aes256 -d -a -A -S "${salt}" -k "$5")

##Logic Check
if [[ ! -f "${update_path}/${update_name}/Contents/Resources/startosinstall" ]]; then
	echo "Error: Update Not found"
exit 1
else

echo "${secure_token_pass}" | ${update_path}/${update_name}/Contents/Resources/startosinstall --forcequitapps --agreetolicense --user ${lapsuser} --stdinpass --rebootdelay 30
exit 0
fi
