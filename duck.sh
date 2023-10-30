#!/bin/bash

clear
echo "DUCK MAN YAAAAAAAAAAAAAAAAAAAAOOOOOHHHHH"
sleep 1
echo ""
echo "press Q to exit"
sleep 3
clear
tput cup 0 0
tput invis
while true
do  
	awk '1;/\[[0-9]+A/{system("sleep .05")}' ./rendered_duck
	read -t 0.05 -N 1 input; 
	if [[ $input = "q" ]] || [[ $input = "Q" ]]
	then
		echo
		break
	fi
tput cup 0 0
done
