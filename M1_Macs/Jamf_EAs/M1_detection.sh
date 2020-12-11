#!/bin/bash

#checks for CPU type	
#Varibles
processor=$(/usr/sbin/sysctl -n machdep.cpu.brand_string | grep -o "Intel")

if [[ -n "$processor" ]]; then

echo "<result>Intel</result>"
else
	echo "<result>M1</result>"
fi
