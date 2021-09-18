#!/bin/bash
file_vault_profile_id=""
fv_status=$(fdesetup  status)

if [[ "${fv_status}" != "FileVault is Off." ]]; then
	echo "file vault is on nothing to do here."
exit 0
else
	#Profile Check#
profile_check=$(profiles list -type configuration | awk '{print $4}' | grep "${file_vault_profile_id}")
if [[ ${profile_check} != "${file_vault_profile_id}" ]]; then
#profile missing
	echo "profile is missing from this device"
#Error Exit no profile or File Vault
	exit 1
else
#Profile Present - Kick user out to start file vault
user_pid=$(ps -Ajc | grep loginwindow | awk '{print $2}')
sudo kill ${user_pid}
fi
fi
