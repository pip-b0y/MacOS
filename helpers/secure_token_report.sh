#!/bin/bash
#This script ran in terminal will give you every user status of secure tokens
list_read='/tmp/userlist.file'
#create list
dscl . list /Users | grep -v “^_” > /tmp/userlist.file
while read -r user_name;do
sysadminctl -secureTokenStatus ${user_name}
done < $list_read
