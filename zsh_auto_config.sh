#!/bin/bash

#Colors (use ${COLOR})
CLEAR='\033[0m'
WHITE='\033[1;37m'
BLACK='\033[1;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT_GRAY='\033[1;30m'
LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
LIGHT_YELLOW='\033[1;33m'
LIGHT_BLUE='\033[1;34m'
LIGHT_PURPLE='\033[1;35m'
LIGHT_CYAN='\033[1;36m'

echo -ne "${LIGHT_YELLOW}"
read -r -p "Update and upgrade package(s) (recommended) ? [Y/n] " response
echo -e "${clear}"
if [[ "$response" =~ ^([nN][oO]|[nN])$ ]]
then		
	echo -e "${LIGHT_PURPLE}Skipping package(s) upgrade.${CLEAR}"
else

	echo -e "${LIGHT_PURPLE}Updating and upgrading package(s)...${CLEAR}"
	sudo apt-get update && sudo apt-get upgrade -y
	echo -e "${LIGHT_GREEN}Done.${CLEAR}"
fi

echo -e "${LIGHT_PURPLE}Installing ZSH... ${CLEAR}"
sudo apt-get install -y zsh

# Create the .zshenv with the user's binary path
cat > .zshenv <<EOF
# Add the local path
path+=("\$HOME/bin")
path+=("\$HOME/.local/bin")
path+=("/usr/sbin/")
EOF

echo -ne "${LIGHT_YELLOW}"
read -r -p "Install oh-my-zsh ? [y/N] " response
echo -e "${CLEAR}"
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	sudo apt-get install -y curl git
	export RUNZSH=no	# We do not want zsh to run after the install
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	
	# Install PowerLevel10k
	echo -ne "${LIGHT_YELLOW}"
	read -r -p "Install PowerLevel10k ? [y/N] " response
	echo -ne "${CLEAR}"
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
		sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
	fi
	echo -e "${LIGHT_GREEN}PowerLever10k installed. ${CLEAR}"
	
	# Install plugins for ZSH
	echo -ne "${LIGHT_YELLOW}"
	read -r -p "Install Zsh-AutoSuggestions and Zsh-Syntax-Highlighting ? [y/N] " response
	echo -ne "${CLEAR}"
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
		sed -i '/^plugins=/s/git/&\n    zsh-autosuggestions\n    zsh-syntax-highlighting/' ~/.zshrc
	fi
	echo -e "${LIGHT_GREEN}Plugins installed. ${CLEAR}"	
	echo -e "${LIGHT_GREEN}Done. ${CLEAR}"
	echo -e "${LIGHT_Purple}Reopen this terminal to finish the config. ${CLEAR}"
else
	echo -e "${LIGHT_RED}ZSH not installed. ${CLEAR}"
fi
