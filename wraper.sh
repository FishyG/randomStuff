#!/bin/bash

#Colors (use ${COLOR_NAME})
CLEAR='\033[0m'
RED='\033[1;31m'
PURPLE='\033[1;35m'

DUCK_RENDER=~/.ducky/duck_render
if [ -f "$DUCK_RENDER" ]
then
	echo "$DUCK_RENDER exists."
else
	echo -e "${PURPLE}Cweating \"~/.ducky\" diwectowy >.< ...${CLEAR}"
	sleep 1
	mkdir -p ~/.ducky

	# Getting the ascii art from github
	echo -e "${PURPLE}Getting the x3 ascii awt OwO...${CLEAR}"
	sleep 2
	if command -v wget &> /dev/null
	then
		wget --quiet -P ~/.ducky/ https://raw.githubusercontent.com/FishyG/randomStuff/main/duck.ascii	
	else

		echo -e "${RED}Oh nyo, w-w-wget (・\`ω´・) nyot found *confusion*${CLEAR}"
		sleep 1
		echo -e "${PURPLE}Imma twy with curl ^w^...${CLEAR}"
		sleep 2
		if command -v curl &> /dev/null
		then
			curl -so ~/.ducky/duck.ascii https://raw.githubusercontent.com/FishyG/randomStuff/main/duck.ascii
		else
			echo -e "${RED}Nyot even OwO curl ?!! ${CLEAR}"
			sleep 2

			# Install wget if not present
			echo -e "${PURPLE}Don't wowwy, imma instawl i-it fow you >w<${CLEAR}"
			sleep 1
			sudo apt-get install -y curl
			curl -so ~/.ducky/duck.ascii https://raw.githubusercontent.com/FishyG/randomStuff/main/duck.ascii
		fi
	fi

	# Getting the rendering script from github 
	echo -e "${PURPLE}Getting the x3 wendewing scwipt...${CLEAR}"
	sleep 2
	if command -v wget &> /dev/null
	then
		wget --quiet -P ~/.ducky/ https://raw.githubusercontent.com/FishyG/randomStuff/main/renderer.sh
	else
		echo -e "${RED}Oh nyo, w-w-wget (・\`ω´・) nyot found *visible confusion*${CLEAR}"
		sleep 1
		echo -e "${PURPLE}Imma twy with curl ^w^...${CLEAR}"
		sleep 2
		curl -so ~/.ducky/renderer.sh https://raw.githubusercontent.com/FishyG/randomStuff/main/renderer.sh
	fi
	chmod +x ~/.ducky/renderer.sh

	echo -e "${PURPLE}Stawting ( ੭•͈ω•͈)੭ the x3 wendewing of the ducky...${CLEAR}"
	sleep 2
	if ! command -v lolcat &> /dev/null
	then
		echo -e "${RED}You fowgot t-to instaww \"lolcat\" you siwwy *looks at you* goose :3${CLEAR}"
		sleep 2
		echo -e "${PURPLE}Don't wowwy, imma instawl i-it fow you ( ˶ˆ꒳ˆ˵ )${CLEAR}"
  		sleep 1
		sudo apt install -y lolcat
	fi
 	if ! command -v toilet &> /dev/null
	then
		echo -e "${RED}You fowgot t-to instaww \"toilet\" you siwwy *looks at you* goose :3${CLEAR}"
		sleep 1
		echo -e "${PURPLE}Don't wowwy, imma instawl i-it fow you ( ˶ˆ꒳ˆ˵ )${CLEAR}"
  		sleep 1
		sudo apt install -y toilet
	fi
	cat ~/.ducky/duck.ascii | ~/.ducky/renderer.sh $HOSTNAME > $DUCK_RENDER
fi

clear
echo -e "${PURPLE}DUCK MAN YAAAAAAAAAAAAAAAAAAAAOOOOOHHHHH${CLEAR}"
sleep 1
echo ""
echo "press Q to exit :3"
sleep 2
clear
tput cup 0 0
tput invis
while true
do  
	awk '1;/\[[0-9]+A/{system("sleep .05")}' $DUCK_RENDER
	read -t 0.05 -N 1 input; 
	if [[ $input = "q" ]] || [[ $input = "Q" ]]
	then
		clear
		echo -e "${PURPLE}Bye bye UwU${CLEAR}"
		break
	fi
tput cup 0 0
done

