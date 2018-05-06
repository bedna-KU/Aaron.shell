#!/bin/bash

# if directory "/tmp/Aaron.shell" no exist create it
if [ ! -d /tmp/Aaron.shell ];then
	mkdir /tmp/Aaron.shell
	chmod 0700 /tmp/Aaron.shell
fi

# Join all args into one string
cmd="$*"
#~ arg=$1
#~ cmd="echo $1 | $(sed -e 's/1//g')"
#~ cmd=$(echo $cmd | sed 's/+/%2B/g')
cmd="${cmd/+/%2B}"
# Help
if [ "$1" = "-h" ]; then
	echo "Help for command aaron.shell"
	echo ""
	echo "-h for this help"
	echo "-l for login"
	echo "-u for logout"
#login
elif [ "$1" = "-l" ]; then
	# Enter name
	echo -n "Enter your name and press [ENTER]: "
	read name
	# Enter password
	unset password
	echo -n "Enter your password and press [ENTER]: "
	while IFS= read -p "$prompt" -r -s -n 1 char
	do
		if [[ $char == $'\0' ]]
		then
			break
		fi
		prompt='*'
		password+="$char"
	done
	echo
	wget --save-cookies /tmp/Aaron.shell/cookies.txt --keep-session-cookies -O /tmp/Aaron.shell/output.txt "https://www.kernelultras.org/API.php?step=action&shell=login $name&data=$password" 2> /dev/null
	chmod 0700 /tmp/Aaron.shell/output.txt
	chmod 0700 /tmp/Aaron.shell/cookies.txt
	wget --load-cookies /tmp/Aaron.shell/cookies.txt --keep-session-cookies -O /tmp/Aaron.shell/output.txt "https://www.kernelultras.org/API.php" 2> /dev/null
	chmod 0700 /tmp/Aaron.shell/output.txt
	wget --load-cookies /tmp/Aaron.shell/cookies.txt --keep-session-cookies -O /tmp/Aaron.shell/output.txt "https://www.kernelultras.org/API.php?shell=id" 2> /dev/null
	chmod 0700 /tmp/Aaron.shell/output.txt
	sed -e 's/<[^>]*>//g' /tmp/Aaron.shell/output.txt
	echo ""
# logout
elif [ "$1" = "-u" ]; then
	wget --load-cookies /tmp/Aaron.shell/cookies.txt --keep-session-cookies -O /tmp/Aaron.shell/output.txt "https://www.kernelultras.org/API.php?shell=logout" 2> /dev/null
	chmod 0700 /tmp/Aaron.shell/output.txt
	#~ rm /tmp/Aaron.shell/cookies.txt
	wget --save-cookies /tmp/Aaron.shell/cookies.txt --keep-session-cookies -O /tmp/Aaron.shell/output.txt "https://www.kernelultras.org/API.php" 2> /dev/null
	chmod 0700 /tmp/Aaron.shell/output.txt
	wget --load-cookies /tmp/Aaron.shell/cookies.txt --keep-session-cookies -O /tmp/Aaron.shell/output.txt "https://www.kernelultras.org/API.php?shell=id" 2> /dev/null
	chmod 0700 /tmp/Aaron.shell/output.txt
	sed -e 's/<[^>]*>//g' /tmp/Aaron.shell/output.txt
	echo ""
# If no command
elif [ -z "$1" ]; then
	wget --load-cookies /tmp/Aaron.shell/cookies.txt --keep-session-cookies -O /tmp/Aaron.shell/output.txt "https://www.kernelultras.org/API.php" 2> /dev/null
	chmod 0700 /tmp/Aaron.shell/output.txt
	sed -e 's/<[^>]*>//g' /tmp/Aaron.shell/output.txt
	echo ""
# Else call command
else
	wget --load-cookies /tmp/Aaron.shell/cookies.txt --keep-session-cookies -O /tmp/Aaron.shell/output.txt "https://www.kernelultras.org/API.php?shell=$cmd | rt" 2> /dev/null
	chmod 0700 /tmp/Aaron.shell/output.txt
	#~ sed -e 's/<[^>]*>//g' /tmp/Aaron.shell/output.txt
	sed -e 's/<[^>]*>//g' /tmp/Aaron.shell/output.txt
	#~ output="$(echo $output | sed 's/B/*/g')"
	#~ echo $output
	echo
fi
