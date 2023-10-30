#!/bin/bash

DUCK_RENDER=~/.ducky/duck_render
if [ -f "$DUCK_RENDER" ]; then
		echo "$DUCK_RENDER exists."
	else
		echo "Cweating \"~/.ducky\" diwectowy >.< ..."
		mkdir -p ~/.ducky

		echo "Getting the x3 ascii awt OwO..."
		if command -v <wget> &> /dev/null
		then
			wget
		else

			echo "Oh nyo, w-w-wget (・\`ω´・) nyot found *confusion*"
			if command -v <curl> &> /dev/null
			then
				curl
			else
				echo "Nyot even OwO curl ?!!"
				# Install wget if not present
				echo "Don't wowwy, imma instawl wget fow you >w<"
				sudo apt-get install -y wget
				wget 
			fi
		fi




fi


