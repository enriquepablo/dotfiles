# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set command line editing to vi-mode
# set -o vi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
*)
    PS1='\[\033[01;34m\](\[\033[01;31m\]\w\[\033[01;34m\])\n\[\033[00;36m\][\j] \[\033[01;34m\]${debian_chroot:+($debian_chroot)}\[\033[01;55m\]\u@\h\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# remap some keys

# xmodmap -e "keycode  21 = dollar questiondown dollar questiondown dead_tilde asciitilde"
# xmodmap -e "keycode  13 = 4 exclamdown 4 exclamdown asciitilde dollar"

# xmodmap -e "keycode  16 = 7 ccedilla 7 ccedilla braceleft seveneighths"
# xmodmap -e "keycode  51 = slash Ccedilla slash Ccedilla braceright dead_breve"


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# function to cd and activate a virtualenv in ~/virtualenvs

venv () {
    tn $1
    echo "Activando ${1}"
    cd
    cd "virtualenvs/${1}"
    source bin/activate
}

#zope () {
#    if [ -f bin/$1 ]; then
#        bin/$1 $2
#    else
#        echo "no script"
#    fi
#}

#fgz () {
#    venv $1
#    bin/instance fg
#}

#ipz () {
#    venv $1
#    zope ipzope ""
#}
#
#dbz () {
#    venv $1
#    zope instance debug
#}
if [ -f /etc/django_bash_completion ]; then
    . /etc/django_bash_completion
fi


if [ -f ~/venvs/default/bin/activate ]; then
    . ~/venvs/default/bin/activate
fi

if [ -f ~/bin/venv ]; then
    . ~/bin/venv
fi

tn ()
{
    if [ $1 ]; then
        NAME=${1}
    else
        NAME=`kdialog --inputbox tabname tabname`
    fi
    PROMPT_COMMAND='echo -ne "\033]0;${NAME}\007"'
}

# abre: busca y abre en un gvim remoto
#
abre ()
{ 
    find ./ -name "$1" -exec gvim --remote {} +
}

if [ -f /etc/bash_completion.d/git ]; then
  source /etc/bash_completion.d/git
fi

# [[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"
