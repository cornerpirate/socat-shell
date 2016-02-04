# socat-shell

When you get a shell on a linux server you get a really limited level of interactivity.
You can use socat to establish a fully interactive shell which allows:
* Tab autocompletion
* Job management by CTRL+C and CTRL+Z etc
* Bash history via CTRL+R etc. 
Basically you get bash as if you are SSHed into the target.

In order to get this goodness you need to:
* 1) Already have a shell on the victim
* 2) Have a means of uploading files to the victim
* 3) Have an established means of communicating to your listener (using TCP).
This tool is not going to find any vulnerbilities for you, or confirm egress filtering. 
This will only be useful in elevating your existing shell to a more functional one.

The victim must either have "socat" installed, or both "gcc" and "make" so that compilation is possible.

Your listener server must have "socat" installed (by default on Kali).

Upload the socat.tar file to your victim, and use your existing shell access to extract that.
By executing "socat-shell.sh" you will achieve the following:
* 1) Check for the existence of the "socat" binary in the current directory.
* 2) If it does not find that then it will check for "gcc" and "make".
* 3) If those pre-reqs are met, then it will extract the socat source and compile it
* 4) When successful the binary for "socat" will now exist in the current directory. Additionally, the last lines of output will show how to start your listener and how to execute the connection back from the victim.

Dislaimer

For research purposes only, do not use this on any target which you do not have permission to do so.
