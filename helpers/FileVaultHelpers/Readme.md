This script need you to get the profile identifier for your File Vault enforcement Profie. You can look at a device record, Or you can use the profiles command on MacOS to find the value. 
You need to use this value in the $file_vault_profile_id varrible
Script is as is and will not be tested 

Exit 0 Means that the device is disk encrypted so no point checking for the profile
Exit 1 means the machine is neither Encrypted nor does it have the Profile inplace. 
Exit 1 means you need to install the file vault profile on the device and try the script again.

SCRIPT IS AS IS.
#the world is a mean enough place. Be nice to each other
