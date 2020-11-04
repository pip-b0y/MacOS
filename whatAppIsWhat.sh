#!/bin/bash
###MASA or Package installed
app_list_write=$(ls /Applications/ | grep ".*\.app" >> /tmp/macOSapp.tmp)
app_list_read="/tmp/macOSapp.tmp"
###
###
#Script Start
while read -r app_name; do
	if [ -d "/Applications/$app_name/Contents/_MASReceipt" ] ; then
		echo ${app_name} >> /tmp/mac_app_store.log
		else 
			echo ${app_name} >> /tmp/not_mac_app_store.log
			fi
			done < ${app_list_read}