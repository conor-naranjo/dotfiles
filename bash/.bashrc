#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
alias ls='ls -G'

# use python3 pip
# alias pip='pip3'

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

# Setup nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export NPM_GLOBAL=$HOME/.npm-global/bin
export GEM_HOME=~/.ruby/
export PATH=$HOME/Library/Python/3.9/bin:/opt/local/bin:/opt/local/sbin:/opt/homebrew/bin:$PATH:$GOROOT/bin:$GOPATH/bin:$NPM_GLOBAL:$GEM_HOME/bin:$HOME/bin:$HOME/.rd/bin
export BASH_SILENCE_DEPRECATION_WARNING=1

# Tmux 256 color
export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo

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

#setup terminal tab title
function title {
    if [ "$1" ]
    then
        unset PROMPT_COMMAND
        echo -ne "\033]0;${*}\007"
    else
        export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
    fi
}

# Enable programmable completion features
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2022-08-16 22:01:59
export PATH="$PATH:$HOME/.local/bin"
