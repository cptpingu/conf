unalias -a

if [[ `uname -s` = "FreeBSD" ]] ; then
    alias ls="ls -GhF"
elif [[ `uname -s` = "Linux" ]] ; then
    alias ls="ls --color=auto -hF"
fi
alias la='ls -ah'
alias l='ls -lh'
alias lt='l -th'
alias ll='la -lh'
alias llt='ll -th'

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
alias mkdir="mkdir $1 && chmod 755 $1"
alias touch="touch $1 && chmod 644 $1"
alias egrep="egrep --color --exclude='*.svn*'"
alias grep="grep --color --exclude='*.svn*'"
alias esed='sed --regexp-extended'
alias screen="screen -U"
alias xgcc='gcc -W -Wall'
alias fixme='grep -rn FIXME .'
alias xvalgrind='valgrind --leak-check=full --leak-resolution=high --show-reachable=yes'
alias pwgen='pwgen --symbols --secure --num-passwords=5 --capitalize -C --ambiguous 12'
alias dls="~/script/ls.sh"
alias junk='rm -i *~ *# *.exe exe a.out *.log *.aux *.toc *.tmp'
alias auth='echo "* $USER" > AUTHORS ; chmod 640 AUTHORS'
alias helpmount="echo 'mount -t iso9660 -o loop /path/to/isoimage.iso /path/to/mount/point/'"
alias bin2avi="~/script/bin2avi.sh"
alias starcraft="~/script/starcraft.sh"
if which colormake >/dev/null 2>&1; then
    alias make='colormake'
fi
if which colordiff >/dev/null 2>&1; then
    alias diff='colordiff'
fi
if which colorgcc >/dev/null 2>&1; then
    alias gcc='colorgcc'
fi

function x-ssh-agent()
{
    eval $(ssh-agent)
    ssh-add
}

function xgdb ()
{
  emacs --eval "(gdb \"gdb --annotate=3 $*\")";
}
