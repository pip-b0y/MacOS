#!/bin/bash
#PPPC-logger version 1 
#Notes:
#This is a viable script. You can run in when you have logged into the machine and run software that is hitting PPPC prompts 
#You can test issues during the login process by SSH into the target machine and executing this script. 
# Please note you need to keep your SSH session open, Go to the machine and log in. The PPPC Logs will be captures as 
# PPPC is a global level log so we can see it all. 


edate=$(date +%Y-%m-%d%n)
echo "This script will start to log the PPPC activitiy please note this wont fix any issues but will help find them."
echo "you will find the log file created in /var/log labled $edate-pppc.log"
echo "for tansparancy, we will collect the version of MacOS this client is running due to the nature of PPPC"
echo "if you agree please press enter so we can execute this script"
read -n 1 -s -r -p "please press any key to begin"
clear 
echo "please press control C to stop the script when finished"
#starting logging 
sudo touch /var/log/$edate-pppc.log
sw_vers >> /var/log/$edate-pppc.log
sudo /usr/bin/log stream --debug --predicate 'subsystem == "com.apple.TCC" AND eventMessage BEGINSWITH "AttributionChain"' >> /var/log/$edate-pppc.log