#!/bin/bash
#bootStrapDoctor#
#please use https://github.com/pip-b0y/Random_tools/blob/main/PasswordMash/PasswordMash_signed.dmg to generate the secure password values. $4 and $5 these values are hard set in Jamf Pro, while the salt is hard coded here in the script. Its an attempt to break up the flow of information 
###Password Masher Notes:
#$4 is the Encrypted String
#$5 is the Passphrase.
#Salt needs to be hard coded here
#Varibles
message="BootStrapDoctor: [Info]"
lapsuser="" #LAPS User is the managed account with a secure token
salt="" #this is the salt value that gets generated from PasswordMasher

#Password Transform
secure_token_pass=$(echo "$4" | /usr/bin/openssl enc -aes256 -d -a -A -S "${salt}" -k "$5")


######Token check
logger "${message} Running the check on the token in the MDM"
token_status=$(/usr/bin/sudo /usr/bin/profiles validate -type bootstraptoken -user=${lapsuser} -password=${secure_token_pass} | grep "profiles: Bootstrap Token validated.")

if [ "${token_status}" == "profiles: Bootstrap Token validated."  ]; then
	echo "<result>BootStrap is Good</result>"
logger "${message} BootStrap token is good nothing to do here"
exit 0
else
logger "${message} BootStrap token is either missing or not right, regenning it"
sudo profiles install -type bootstraptoken -user=$lapsuser -password=${secure_token_pass}
###Double Check it worked!
token_status_post_run=$(/usr/bin/sudo /usr/bin/profiles validate -type bootstraptoken -user=${lapsuser} -password=${secure_token_pass} | grep "profiles: Bootstrap Token validated.")
if [ "${token_status_post_run}" == "profiles: Bootstrap Token validated."  ]; then
logger "${message} Boot Strap Token is there now. We can exit"
	echo "<result>BootStrap is Good</result>"
else
logger "${message} token is still bad something went wrong"
echo "<result>TOKEN BAD</result>"
exit 1
fi
fi