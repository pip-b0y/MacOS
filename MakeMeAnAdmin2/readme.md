This is an as is product. 

1 - You need to add the EA to Jamf Pro and create a smart group to look for the ea value of AdminRightsRequested
2 - Users need to run the script MakeMeAnAdminRequest.sh first. It will prime the script to make an admin. It will allow the time if it is requested in seconds and it will also check to see if the user agrees. There is logging that is reasons in the jamf log
3 - Is the script you scope a user to that makes the request. the 2script needs to run as there is values that the MakeMeAnAdminV2 will use. So it is a must to run the first script first. 
4 - If a user reboots their admin rights are striped on restart 
