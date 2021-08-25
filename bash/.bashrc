#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# sdcv searches a dict file in ~/stardict/dic
alias define='sdcv'

# Opens Firefox on a fresh, disposable profile
alias fx='firefox --new-instance --profile $(mktemp -d)'

# Cycle through available options on tab-completion:
[[ $- = *i* ]] && bind TAB:menu-complete
# Cycle through previous option on Shift+Tab
bind '"\e[Z":menu-complete-backward'

color1=$(tput setf 5)
color2=$(tput setf 1)
color3=$(tput setf 6)
color4=$(tput setf 2)
color5=$(tput setf 7)

#PS1='[\u@\h \W]\$ '
PS1='\$ '

export PATH=$PATH:/usr/local/go/bin

shopt -s extglob

if [ -x /usr/games/cowsay -a -x /usr/games/fortune ]; then
	fortune | cowsay
fi

# Make and change into a directory
mkcd() {
	if [[ $# -eq 0 ]] ; then
		echo "Error: No arguments supplied."
		echo "Usage: mkcd <folder_name>"
	    	return 1 
    	fi	
	
	local dir="$1"
	mkdir "$dir" && cd "$dir" > /dev/null; pwd
}

# Change into directory and list contents
cdls() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null; ls
	else
		echo "bash: cl: $dir: Directory not found."
	fi
}

# Gets public IP address
getip() {
	elinks -dump http://whatismyip.org | grep "Your IP:"
}

# Enable programmable completion features
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion]; then
		. /etc/bash_completion
	fi
fi
