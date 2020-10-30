This should be deployed via mdm. 
You need to install a profile that is targeting this plist
com.auto-logout-inactive-user.plist
The following are the settings
For the log out time / inactive time it is calculated in seconds. so for 30 minutes it will be 30x60=1800. The 1800 is the integer
<plist>
<dict>
<key>IdleTime</key>
<integer>TIMEHERE</integer>
</dict>
</plist>

This is as is, You might need to deploy a TCC Script to allow the usuage of osascript for the script to operate correctly

AS IS PROGRAM
