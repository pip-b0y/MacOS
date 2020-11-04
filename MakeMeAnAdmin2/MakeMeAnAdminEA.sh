#!/bin/bash

#Make me an admin Request EA
#will check to see if the request policy has been executed.
targetfile="/Library/Application Support/JAMF/.adminrequest"

if test -f "${targetfile}"; then
	echo "<result>AdminRightsRequested</result>"
	else
		echo "<result>Null</result>"
		fi
		