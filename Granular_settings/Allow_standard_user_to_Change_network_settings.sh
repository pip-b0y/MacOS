#!/bin/bash
#Script is as is
#Tested on a M1 device running latest version of MacOS12.2
#Note that settings may change in future releases of MacOS. Must run as root in a policy
/usr/bin/security authorizationdb write system.preferences.network allow
/usr/bin/security authorizationdb write system.services.systemconfiguration.network allow
exit 0
