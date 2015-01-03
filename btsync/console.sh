#!/bin/bash

cmds="Commands: {folders|add-folder|remove-folder|detach|clear|help|ls|cd|mkdir|rm}"
echo $cmds

while true; do
    
    read -p "> " -a cmd

    args=$(printf " %s" "${cmd[@]}")
	args=${args:1}

    case ${cmd[0]} in

        folders ) nodejs /btsync/btsync.js folders;;
		
		add-folder ) nodejs /btsync/btsync.js $args; nodejs /btsync/btsync.js restart;;

		remove-folder ) nodejs /btsync/btsync.js $args; nodejs /btsync/btsync.js restart;;
		
		detach ) echo "Detach from container: Ctrl-p Ctrl-q";;

		clear ) clear;;

		ls ) $args;;

		cd ) $args;;

		mkdir ) $args;;

		rm ) $args;;

		help ) echo $cmds;;		
        
        * ) echo $cmds;;
    
    esac
done