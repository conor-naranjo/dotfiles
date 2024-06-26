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

color_red=$(tput setaf 1)
color_green=$(tput setaf 2)
color_yellow=$(tput setaf 3)
color_white=$(tput setaf 7)

# Get Git branch of current directory
git_branch () {
    if git rev-parse --git-dir >/dev/null 2>&1
        then echo -e "" git:\($(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')\)
    else
        echo ""
    fi
}

# Set a specific color for the status of the Git repo
git_color() {
    local STATUS=`git status 2>&1`
    if [[ "$STATUS" == *'Not a git repository'* ]]; then
        echo "" # nothing
    elif [[ "$STATUS" != *'nothing to commit'* ]]; then
        echo -e ${color_red}  # red if need to commit
    elif [[ "$STATUS" == *'Your branch is ahead'* ]]; then
        echo -e ${color_yellow}  # yellow if need to push
    else
        echo -e ${color_green}  # else green
    fi
}
PS1=' \[\w $(git_color)$(git_branch)${color_white} \n \$ '

export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export NPM_GLOBAL=$HOME/.npm-global/bin
export GEM_HOME=~/.ruby/
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$NPM_GLOBAL:$GEM_HOME/bin:$HOME/bin:$HOME/.dotnet/tools

shopt -s extglob

if [ -x $(command -v cowsay) -a -x $(command -v fortune) ]; then
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
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

function title {
    if [ "$1" ]
    then
        unset PROMPT_COMMAND
        echo -ne "\033]0;${*}\007"
    else
        export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
    fi
}
