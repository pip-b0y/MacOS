#!/bin/bash
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

currentuser=$(id -un)
lapsuser=$(echo "$4" | /usr/bin/openssl enc -aes256 -d -a -A -S "$5" -k "$6")
lapspass=$(echo "$7" | /usr/bin/openssl enc -aes256 -d -a -A -S "$8" -k "$9")
enduserpassword1_raw=$( /usr/bin/osascript -e "display dialog \"Please enter your password\" with hidden answer default answer \"\" with title \"please enter your password \" buttons {\"Cancel\",\"submit\"} default button {\"submit\"}" | /usr/bin/awk -F "text returned:|," '{print $3}')
#confirm password
enduserpassword2_raw=$( /usr/bin/osascript -e "display dialog \"Please confirm your password\" with hidden answer default answer \"\" with title \"please confirm your password \" buttons {\"Cancel\",\"submit\"} default button {\"submit\"}" | /usr/bin/awk -F "text returned:|," '{print $3}')
#Compare the passwords
if [ "${enduserpassword1_raw}" == "$enduserpassword2_raw}" ]; then
#Password Match
sysadminctl -adminUser "${lapsuser}" -adminPassword "${lapspass}" -secureTokenOn "${currentuser}" -password "${enduserpassword1_raw}"
else
#password didnt match try again
enduserpassword3_raw=$( /usr/bin/osascript -e "display dialog \"Please enter your password\" with hidden answer default answer \"\" with title \"please enter your password \" buttons {\"Cancel\",\"submit\"} default button {\"submit\"}" | /usr/bin/awk -F "text returned:|," '{print $3}')
	#confirm password
enduserpassword4_raw=$( /usr/bin/osascript -e "display dialog \"Please confirm your password\" with hidden answer default answer \"\" with title \"please confirm your password \" buttons {\"Cancel\",\"submit\"} default button {\"submit\"}" | /usr/bin/awk -F "text returned:|," '{print $3}')
#compare passwords
if [ "${enduserpassword3_raw}" == "$enduserpassword4_raw}" ]; then
#match
sysadminctl -adminUser "${lapsuser}" -adminPassword "${lapspass}" -secureTokenOn "${lapsuser}" -password "${enduserpassword4_raw}"
else
	echo "Bad password entered twice"
	exit 1
fi
fi
