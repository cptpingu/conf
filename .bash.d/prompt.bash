function prompt()
{
    RET=$?

    system=$(uname -s)
    tmp="${USER}@${HOSTNAME}:${PWD} "
    promptsize=${#tmp}
    if [[ "${COLUMNS}" = "" ]] ; then
	fillsize=$((80 - ((${promptsize} + 5) % 80)))
    else
	fillsize=$((${COLUMNS} - ((${promptsize} + 5) % ${COLUMNS})))
    fi
    fillchar="-"
    fill=""
    # Make the filler if prompt isn't as wide as the terminal:
    while [[ ${fillsize} -gt "0" ]]
    do
	fill="${fill}${fillchar}"
    # The A with the umlaut over it (it will appear as a long dash if
    # you're using a VGA font) is \304, but I cut and pasted it in
    # because Bash will only do one substitution - which in this case is
    # putting $fill in the prompt.
	let fillsize=${fillsize}-1
    done

    if [ $RET -ne 0 ] ; then
	RET="$redB$RET"
    fi

    # Check if we were root
    prompt_color=$yellowB
    if [ $UID -eq 0 ]; then
	prompt_color=$redB
    fi
    PS1="$prompt_color[\u@\H]$green${PWD}"\
"$yellowB${fill}$(date +%H:%M)\n"\
"$blueB[\[$greenB$RET$blueB]"\
"$blueB[jobs:\[\033[1;36m\]\j$blueB]"\
"$grey\$ $white"

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
