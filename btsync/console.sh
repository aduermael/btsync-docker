#!/bin/bash

cmds="Commands: {folders|add-folder|remove-folder|detach|clear|help|stop}"
echo $cmds

while true; do
    
    read -p "> " -a cmd

    args=$(printf " %s" "${cmd[@]}")
	args=${args:1}

    case ${cmd[0]} in

        folders ) nodejs btsync.js folders;;
		
		add-folder ) nodejs btsync.js $args;;

		remove-folder ) nodejs btsync.js $args;;
		
		detach ) exit;;

		clear ) clear;;

		help ) echo $cmds;;		
        
        stop ) exit;;
        
        * ) echo $cmds;;
    
    esac
done