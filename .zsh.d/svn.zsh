SVN=`which /usr/bin/svn` || SVN=$(which svn)

svndiff()
{
    $SVN diff "$@" | colordiff | less -R
}

svnst()
{
    $SVN st "$@" | sed '
s/$/'${white}'/g
s/^M/'${blue}'M/g
s/^ M/'${blue}' M/g
s/^!/'${magenta}'!/g
s/^\?/'${yellow}'\?/g
s/^A/'${green}'A/g
s/^D /'${red}'D /g
s/^C /'${redB}'C /g
'
}

svnup()
{
    $SVN up "$@" | sed '
s/revision \([0-9]\+\)\.$/revision '${cyanB}'\1'${white}'\./g
s/^Restored /'${yellow}'Restored /g
s/$/'${white}'/g
s/^U /'${cyan}'U /g
s/^ U /'${cyan}' U /g
s/^C /'${red}'C /g
s/^A /'${green}'A /g
s/^G /'${yellow}'G /g
s/^ G /'${yellow}' G /g
s/^D /'${magenta}'D /g
'
}

svnadd()
{
    $SVN add "$@" | sed '
s/$/'${white}'/g
s/^A /'${green}'A /g
'
}

svnci()
{
    for i in $(seq 1 $#); do
        if test $(eval echo \$$i) = '-m' ; then
            $SVN ci "$@" | sed '
s/revision \([0-9]\+\)\.$/revision '${cyanB}'\1'${white}'\./g
s/$/'${white}'/g
s/^Sending /'${green}'Sending /g
s/^Adding /'${yellow}'Adding /g
s/^Deleting /'${red}'Deleting /g
'
            return
        fi
    done
    $SVN ci "$@"
}

svn()
{
    case $1 in
        st)     shift; svnst "$@";;
        diff)   shift; svndiff "$@";;
        up)     shift; svnup "$@";;
	ci)	shift; svnci "$@";; # breaks editors :/
        add)    shift; svnadd "$@";;
        *)      $SVN "$@";;
    esac
}
