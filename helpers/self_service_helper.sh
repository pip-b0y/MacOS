#!/bin/bash
#This script will work provided that TCC rigts are given for the jamf binary. It is a install assistant using the JamfSelfService URLS. Currently the install function does not work as inteded. This will help.
###Notes####
#$4 = app, policy, configprofile
# app = install or view description of app in self service. Using a Policy varible of $4 (first in the list)
# policy = install or view description of a policy in self service. Using a Policy varible of $4 (first in the list)
# configprofile = install or view description of a configprofile in self service. Using a Policy varible of $4 (first in the list)
###
#$5 = Id of the object to be installed via self service . #hint, go to the object you intend to install. EG Apple Configurator. Go to that in self service and look at the URL when viewing the object. You will see id=xx it is that number we want here. It is going to be the 2nd in the list. 

osascript <<EOD
activate application "Self Service"
tell application "System Events" to keystroke "r" using command down
EOD
sleep 5
open "jamfselfservice://content?entity=${4}&id=${5}&action=view"	
#new in v1.3
osascript <<EOD
tell application "System Events" to tell process "Self Service" to tell button "Install" of sheet 1 of window "Self Service" to perform action "AXPress"
tell application "System Events" to tell process "Self Service" to tell button "Close" of sheet 1 of window "Self Service" to perform action "AXPress"
EOD
