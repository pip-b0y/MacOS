#!/bin/bash
#Token Granter v1
#Use https://github.com/pip-b0y/Random_tools/blob/main/PasswordMash/PasswordMash_signed.dmg to generate hashes
###Please generate a Hash before you try this out. The policy will use the hash to perfom the task.
######STARTPASTE###
##function GenerateEncryptedString() {
##Usage ~$ GenerateEncryptedString "String"
##local STRING="${1}"
##local SALT=$(openssl rand -hex 8)
##local K=$(openssl rand -hex 12)
##local ENCRYPTED=$(echo "${STRING}" | openssl enc -aes256 -a -A -S "${SALT}" -k "${K}")
##echo "Encrypted String Vaule 4 or 7: ${ENCRYPTED}"
##echo "Salt Becomes 5 or 8 : ${SALT} | Passphrase becomes 6 or 9: ${K}"
##}
###Use Jamf Pro varibles in the script in a policy to set the keys in place to pass to script on client device. You can opt to hard code the salt or passphrase for added security. You can encrypt the user name too, if you dont want to update the script to reflect this choice by commenting out lines
#have this run as a login policy to enable file vault / secure token access for the user that is using the machine 
####Not ideal method, but helps when needed.
##This script assumes that the account that is $7 is the secure token holder

####Varibles
target_user_home=$(echo ~${7})
target_user_password=$(echo "$4" | /usr/bin/openssl enc -aes256 -d -a -A -S "$5" -k "$6")

###Password Prompt
current_user_prompt=$(/usr/bin/osascript -e "display dialog \"Please enter your username\" default answer \"\" with title \"please enter your username \" buttons {\"Cancel\",\"submit\"} default button {\"submit\"}" | /usr/bin/awk -F "text returned:|," '{print $3}')
enduserpassword1_raw=$( /usr/bin/osascript -e "display dialog \"Please enter your password\" with hidden answer default answer \"\" with title \"please enter your password \" buttons {\"Cancel\",\"submit\"} default button {\"submit\"}" | /usr/bin/awk -F "text returned:|," '{print $3}')
#confirm password
enduserpassword2_raw=$( /usr/bin/osascript -e "display dialog \"Please confirm your password\" with hidden answer default answer \"\" with title \"please confirm your password \" buttons {\"Cancel\",\"submit\"} default button {\"submit\"}" | /usr/bin/awk -F "text returned:|," '{print $3}')
###
if [ "${enduserpassword1_raw}" == "${enduserpassword2_raw}" ]; then
	#password Match can move on and do the grant
	sudo -u ${7} sysadminctl -adminUser "${7}"  -adminPassword "${target_user_password}" -secureTokenOn "${current_user_prompt}" -password "${enduserpassword1_raw}"
	#token should be granted now
"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType hud -title "Token Granted" -heading "Token has been granted" -description "You should be able to enable File Vault now" -button1 okay -defaultButton 0
#echo results to Jamf Pro in case
end_results=$(sysadminctl -secureTokenStatus ${current_user_prompt})
echo "Status ${end_results}"
else
	##bad password prompt user to run policy again
	echo "prompting for re-run"
	"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType hud -title "Alert" -heading "Passwords did not match" -description "Your passwords did not match please run this policy again." -button1 okay -defaultButton 0
fi
