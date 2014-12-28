#!/bin/bash

cmds="Commands: {folders|add-folder|remove-folder|detach|clear|help|ls|cd}"
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

		ls ) $args;;

		cd ) $args;;

		help ) echo $cmds;;		
        
        * ) echo $cmds;;
    
    esac
done