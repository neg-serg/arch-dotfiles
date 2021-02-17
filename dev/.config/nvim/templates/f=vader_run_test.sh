#!/bin/bash
IFS='
'

red="\033[;31m"
yellow="\033[33m"
white="\033[0m"
initial_dir=$(pwd)
script_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

# Remove plugins after testing, true by default
rm_plugins=true
# Don't update plugins if they are already present, true by default
upd_plugins=true

cd "$script_dir" &&

# Installation of vim plugins from github
vim_plugs=('junegunn/vader.vim' %_%) &&
echo -e "${yellow}INSTALLATION OF PLUGINS${white}" &&
for gl in ${vim_plugs[*]}; do
	p=$(echo $gl | cut -d '/' -f 2)
	echo -e "------> $p"
	if [ -d "$p" ]; then
		if [ $upd_plugins = true ]; then
			cd "$p" &&
			git pull -q origin master &&
			echo -e "was updated" &&
			cd '../'
		else
			echo -e "is OK"
		fi
	else
		git clone -q "https://github.com/${gl}" &&
		echo -e "was installed"
	fi
done &&

# Don't run tests if no Vader file is present
if [ "$(ls | grep -c '.vader')" -eq 0 ]; then
	echo -e "${red}No Vader file(s) found${white}"
else
	echo -e "${yellow}RUN TESTS${white}" &&
		vim -Nu vimrc -c 'Vader! main.vader'
fi

# Remove installed vim plugins
if [ $rm_plugins = true ]; then
	echo -e "${yellow}REMOVE INSTALLED PLUGINS${white}" &&
	for p in ${vim_plugs[*]}; do
		rm -rf "$(echo $p | cut -d '/' -f 2)"
	done
fi

cd "$initial_dir"
