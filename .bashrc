# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# We use preexec and precmd hook functions for Bash
# If you have anything that's using the Debug Trap or PROMPT_COMMAND 
# change it to use preexec or precmd
# See also https://github.com/rcaloras/bash-preexec

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#     xterm-color|*-256color) color_prompt=yes;;
# esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

# if [ -n "$force_color_prompt" ]; then
#     if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# 	# We have color support; assume it's compliant with Ecma-48
# 	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# 	# a case would tend to support setf rather than setaf.)
# 	color_prompt=yes
#     else
# 	color_prompt=
#     fi
# fi

# Custom Color Codes UserDef
# ANSI color codes
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
UL="\[\033[4m\]"    # underline
INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
BBLK="\[\033[40m\]" # background black
BRED="\[\033[41m\]" # background red
BGRN="\[\033[42m\]" # background green
BYEL="\[\033[43m\]" # background yellow
BBLE="\[\033[44m\]" # background blue
BMAG="\[\033[45m\]" # background magenta
BCYN="\[\033[46m\]" # background cyan
BWHT="\[\033[47m\]" # background white

# export PS1='[\u@\h \W$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)")]\$ '

# User Defined Color Prompt with GIT Branch
force_color_prompt=yes
color_prompt=yes
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
# export PS1="$HC$FMAG[$FBLE${debian_chroot:+($debian_chroot)}$FCYN\u @ \w$RS $HC$FMAG] $RS$FYEL $(parse_git_branch) $RS$HC$FMAG\\$ $RS"

if [ "$color_prompt" = yes ]; then
   export PS1="$HC$FMAG[$FBLE${debian_chroot:+($debian_chroot)}$FCYN\u @ \w$RS $HC$FMAG]$RS$FYEL \n$(parse_git_branch) $RS$HC$FMAG \\$ $RS"
  else
   export PS1="$HC$FYEL&gt; $(parse_git_branch) $RS"
  fi

# source ~/.bashrc
# unset color_prompt force_color_prompt



# Default Linux Prompt
# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt
##################################################################
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# export PS1
##############################################
# Adding .pyenv temp
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# User Defined Aliases
alias python=python3
alias py=python3
alias pip=pip3

function cs () {
    cd "$@" && ls
}

##############################################

# If this is an xterm set more declarative titles 
# "dir: last_cmd" and "actual_cmd" during execution
# If you want to exclude a cmd from being printed see line 156
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\$(print_title)\a\]$PS1"
#     __el_LAST_EXECUTED_COMMAND=""
#     print_title () 
#     {
#         __el_FIRSTPART=""
#         __el_SECONDPART=""
#         if [ "$PWD" == "$HOME" ]; then
#             __el_FIRSTPART=$(gettext --domain="pantheon-files" "Home")
#         else
#             if [ "$PWD" == "/" ]; then
#                 __el_FIRSTPART="/"
#             else
#                 __el_FIRSTPART="${PWD##*/}"
#             fi
#         fi
#         if [[ "$__el_LAST_EXECUTED_COMMAND" == "" ]]; then
#             echo "$__el_FIRSTPART"
#             return
#         fi
#         #trim the command to the first segment and strip sudo
#         if [[ "$__el_LAST_EXECUTED_COMMAND" == sudo* ]]; then
#             __el_SECONDPART="${__el_LAST_EXECUTED_COMMAND:5}"
#             __el_SECONDPART="${__el_SECONDPART%% *}"
#         else
#             __el_SECONDPART="${__el_LAST_EXECUTED_COMMAND%% *}"
#         fi 
#         printf "%s: %s" "$__el_FIRSTPART" "$__el_SECONDPART"
#     }
#     put_title()
#     {
#         __el_LAST_EXECUTED_COMMAND="${BASH_COMMAND}"
#         printf "\033]0;%s\007" "$1"
#     }
    
#     # Show the currently running command in the terminal title:
#     # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
#     update_tab_command()
#     {
#         # catch blacklisted commands and nested escapes
#         case "$BASH_COMMAND" in 
#             *\033]0*|update_*|echo*|printf*|clear*|cd*)
#             __el_LAST_EXECUTED_COMMAND=""
#                 ;;
#             *)
#             put_title "${BASH_COMMAND}"
#             ;;
#         esac
#     }
#     preexec_functions+=(update_tab_command)
#     ;;
# *)
#     ;;
# esac