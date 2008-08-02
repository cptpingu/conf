unalias -a

if [[ `uname -s` = "FreeBSD" ]] ; then
    alias ls="ls -GhF"
elif [[ `uname -s` = "Linux" ]] ; then
    alias ls="ls --color=auto -hF"
fi
alias la='ls -a'
alias l='ls -l'
alias lt='l -t'
alias ll='la -l'
alias llt='ll -t'

function lcd()
{
    cd "$1" && ls
}
alias pcd='cd -P'
alias df='df -h'
alias du='du -h --max-depth=1'
alias reload="source ~/.bashrc"
alias emacs='emacs -fn 7x14'
alias cls='clear'
alias my_date="date +'%Y%m%d%H%M'"

function ema()
{
    emacs "$@" & disown
}

alias gdb='gdb --quiet' # --tui'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias ps='ps -fx'
alias egrep="egrep --color --exclude='*.svn*'"
alias grep="grep --color --exclude='*.svn*'"
alias esed='sed --regexp-extended'
alias screen="screen -U"
alias xgcc='gcc -W -Wall'
alias fixme='grep -rn FIXME .'
alias xvalgrind='valgrind --leak-check=full --leak-resolution=high --show-reachable=yes'
alias pwgen='pwgen --symbols --secure --num-passwords=5 --capitalize -C --ambiguous 12'
alias junk='rm -i *~ ; rm -i *# ; rm -i *.exe ; rm -i exe'
alias auth='echo "* $USER" > AUTHORS ; chmod 640 AUTHORS'
alias helpmount="echo 'mount -t iso9660 -o loop /path/to/isoimage.iso /path/to/mount/point/'"
alias bin2avi="~/script/bin2avi.sh"
alias starcraft="~/script/starcraft.sh"
if which colormake >/dev/null 2>&1 && false ; then
    alias make='colormake'
fi

function x-ssh-agent()
{
    eval $(ssh-agent)
    ssh-add
}
