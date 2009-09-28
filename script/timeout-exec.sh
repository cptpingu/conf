#!/bin/sh

process_is_running()
{
    ps -a 2> /dev/null | grep -v "grep" | grep "$1" > /dev/null 2>&1
    return $?
}

timeout_exec()
{
    prog=$1
    max_wait_time=${2-"1"}

    $prog > /dev/null 2>&1 &
    last_pid=$!
    launch_time=`date '+%s'`
    cont=1
    while [ $cont -eq 1 ]; do
	process_is_running $last_pid
	if [ $? -ne 0 ]; then
	    cont=0
	fi
	now=`date '+%s'`
	time_elapsed=$(($now - $launch_time))
	if [ $time_elapsed -gt $max_wait_time ]; then
	    kill -s 15 $last_pid 2>&1 > /dev/null
	    return 1
	fi
    done

    return 0
}

timeout_exec "./instant-loop.sh" 2
echo "done : $?"