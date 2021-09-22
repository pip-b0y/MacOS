#!/bin/bash
​
ssh_status=$(systemsetup -getremotelogin)
​
#compare on off
if [[ "${ssh_status}" == "Remote Login: Off" ]];then
	echo "SSH is off"
else
	echo "SSH is on lets deal with it"
	sudo systemsetup -f -setremotelogin off
	echo "SSH is OFF NOW"
fi
