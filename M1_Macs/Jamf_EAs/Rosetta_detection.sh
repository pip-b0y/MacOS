#!/bin/bash

#checks for Rosetta

if [[ ! -f "/Library/Apple/System/Library/LaunchDaemons/com.apple.oahd.plist" ]]; then
	echo "<result>Rosetta not installed</result>"
else
	echo "<result>Rosetta Installed</result>"
fi

