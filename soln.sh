#!/usr/bin/env bash

# Works on linux, your milage may vary on other UNIX based systems like MacOX, cygwin and WSL

if [ "$#" -ne 2 ]; then
    echo "Usage: bash $0 <host> <port>"
fi

printf "Connecting to %s:%s\n" $1 $2

# open socket connection to server as FD number 3
exec 3<>/dev/tcp/$1/$2

# read prompt from FD 3
head -n1 <&3
# read mail ID from terminal
read line
# send mail ID to server through FD number 3
echo $line 1>&3

# do the thing
while true
do
	line=$(head -n1 <&3)
	printf "Got: %s\n" "$line"
	if [ "Hello world" = "$line" ]
	then
		echo "hell world" 1>&3
	else
		break
	fi
done

# close FD
exec 3>&-