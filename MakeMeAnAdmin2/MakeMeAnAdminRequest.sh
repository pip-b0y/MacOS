#!/bin/bash

#first script to request admin rights
#You might need tcc so please test before deploying to clients
#This does not give admin rights it only "Requests it" To be approved by an admin to put device into policy to make an admin
#Varibles#Prompt1
messagetouser="You are about to request admin rights."
messagetouserbutton1="Request" #is the accept
messagetouserbutton2="Cancel" #is the cancel button always
#Varibles#Prompt2
messagetouser2="Please type the ammount of time you want in seconds. Example for 30 minutes you would type in seconds 1800 (30 times 60)"
numberlogic='^[0-9]+$'

#Checking if this is what the user wants to do
	userprompt1=$(/usr/bin/osascript -e "display dialog \"${messagetouser}\" default answer \"Reason for request:\" with title \"Attention\" buttons {\"${messagetouserbutton2}\",\"${messagetouserbutton1}\"} default button {\"${messagetouserbutton1}\"}")
	user_response_button=$( echo "${userprompt1}" | /usr/bin/awk -F "button returned:|," '{print $2}' )
	user_response_text=$(echo "${userprompt1}" | /usr/bin/awk -F "text returned:|," '{print $2}' )
	#Log user respnse if there is one
	echo "${user_respnse_text} for admin rights " >> /var/log/jamf.log
	#check the user reply
	if [ "${user_response_button}" = "${messagetouserbutton1}" ]; then
		#GreenLight
		#Prompt the user again
		time_for_admin=$(/usr/bin/osascript -e "display dialog \"${messagetouser2}\" default answer \"time in seconds\" with title \"Attention\" buttons {\"cancel\",\"Submit\"} default button {\"Submit\"}")
		time_request=$(echo "${time_for_admin}" | /usr/bin/awk -F "text returned:|," '{print $2}')
		buttonhit=$(echo "${time_for_admin}" | /usr/bin/awk -F "button returned:|," '{print $2}')
		#check to see if Submit was hit
		if [ "${buttonhit}" = "Submit" ]; then
			#can continue
		if ! [[ "{$time_request}" =~  "${numberlogic}" ]] ; then
			echo "Not a number will exit"
			exit 1
			else 
				#Creating the number file
				touch /Library/Application Support/JAMF/.time
				echo "${time_request}" >> /Library/Application Support/JAMF/.time
				#Start the ea
				touch /Library/Application Support/JAMF/.adminrequest
				#run a recon
				/usr/bin/jamf recon
				fi
		else
			echo "error user exited"
exit 0
		fi 
		else
			exit 0
			fi