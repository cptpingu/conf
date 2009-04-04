#!/bin/sh

#include global environment
source  ~/.zsh.d/globalenv

export HISTSIZE=1000
export HISTFILE=~/.zshhistory
export SAVEHIST=1000
export BLOCK_SIZE=human-readable
# depth of the directory history
DIRSTACKSIZE=30

#show who login and who logout on the system
export WATCHFMT="%n has %a %l from %M"
export WATCH=all
