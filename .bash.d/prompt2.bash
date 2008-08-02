function prompt()
{
    RET=$?

    if [[ $RET -eq 0 ]] ; then
        RET=""
    else
        RET="\[$redB\]$RET "
    fi

    tmp=$(jobs)
    if [[ ${#tmp} -gt 0 ]] ; then
        JOBS="\[$yellow\]\j "
    else
        JOBS=""
    fi

    my_pwd=$(sed 's,\(/\?.\)[^/]*/,\1/,g' <<<"$PWD" )

    PS1="$RET$JOBS\[$cyan\]\u@\H:\[$blue\]$my_pwd\[$yellow\]> \[$white\]"



# Change the window title of X terminals
    case $TERM in
	*xterm*|*rxvt*|Eterm)
	    echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"
	    ;;
	screen)
	    echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"
	    ;;
    esac
}

PROMPT_COMMAND="prompt"
