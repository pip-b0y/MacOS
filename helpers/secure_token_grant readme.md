Please generate a Hash before you try this out. The policy will use the hash to perfom the task.
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

This is required for the script to work correctly
