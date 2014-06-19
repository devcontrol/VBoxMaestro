#!/bin/bash
#VBoxManager bash script handler

command=$1
server="${@:2}"

case "$command" in
	'start')
		echo "Will start machine: ""$server"
		VBoxManage startvm $server --type=headless
		echo "DONE; \n"
	;;
	'save')
		echo "Will save machine: ""$server"

		for server
		do
			if [ "$server" != "save" ] && [ "$server" != "start" ]
			then
				VBoxManage controlvm $server savestate
			fi
		done	
		echo "DONE; \n"
	;;
	'boot')
		echo "Will load from ./boot"
		set -- $(<./boot)
		VBoxManage startvm $@ --type=headless
		echo "DONE; \n"
	;;
	'sleep')
		echo "Will save all the machines!"
		
		VBoxManage list vms > ./.tmp
		what=`grep -o '".*"' .tmp | sed 's/"//g'`
		runningMachines=$what
		
		for runningMachines in `echo $runningMachines`
		do
			echo "Saving Maschine: $runningMachines"
			VBoxManage controlvm $runningMachines savestate
			echo "DONE;"
			echo ""
		done

	;;
	'*')
		echo "Unknown command: $command"
	;;
esac
