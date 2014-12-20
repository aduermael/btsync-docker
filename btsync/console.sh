#!/bin/bash

cmds="Commands: {folders|add-folder|remove-folder|detach|clear|help|stop}"
echo $cmds

while true; do
    
    read -p "> " -a cmd

    args=$(printf " %s" "${cmd[@]}")
	args=${args:1}

    case ${cmd[0]} in

        folders ) nodejs btsync.js folders;;
		
		add-folder ) nodejs btsync.js $args; nodejs btsync.js restart;;

		remove-folder ) nodejs btsync.js $args; nodejs btsync.js restart;;
		
		detach ) echo "Detach from container: Ctrl-p Ctrl-q";;

		clear ) clear;;

		help ) echo $cmds;;		
        
        stop ) exit;;
        
        * ) echo $cmds;;
    
    esac
done