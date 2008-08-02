# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export EDITOR="emacs"
export MALLOC_OPTIONS="j"
#export NNTPSERVER="news.epita.fr"
#export http_proxy="http://proxy.epita.fr:3128"
#export ftp_proxy="http://proxy.epita.fr:3128"

xset r rate 300 100

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Function to source other script
function my_source()
{
    if test -r "$1" ; then
	source "$1"
    fi
}

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if which dircolors >/dev/null ; then
    eval `dircolors -b`
fi

if [[ $TERM = "linux" ]] ; then
    unicode_start
fi

my_source /etc/bash_completion
my_source ~/.bash.d/alias.bash
my_source ~/.bash.d/env.bash
my_source ~/.bash.d/colors.bash
my_source ~/.bash.d/prompt.bash
my_source ~/.bash.d/svn.bash

complete -d cd
set completion-ignore-case on
set print-completions-horizontally on
set visible-stats on
shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize
umask 0077

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

~/.bash.d/xtiff.pl
