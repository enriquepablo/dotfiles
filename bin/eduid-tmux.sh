#!/bin/bash

SESSION="src-eduid"
SRC_DIR=/home/eperez/src/git

/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/*_rsa

# if the session is already running, attach to it.
tmux has-session -t $SESSION
if [ $? -eq 0 ]; then
	echo "Session $SESSION already exists. Attaching."
	sleep 1
	tmux -2 attach -t $SESSION
	exit 0;
fi


tmux start-server

cd $SRC_DIR

# create a new session, named $SESSION, and detach from it
tmux -2 -f ~/.tmux.conf new-session -d -s $SESSION

# create the windows and set their names

tmux set-window-option -t $SESSION -g automatic-rename off
n=2

for name in eduid-html eduid-dockerfiles eduid-developer eduid-api eduid-userdb eduid-common eduid-am eduid_msg eduid-lookup-mobile eduid-IdP eduid-IdP-html eduid-actions eduid-signup eduid-dashboard eduid-signup-amp eduid-dashboard-amp eduid-api-amp eduid_action.tou eduid_action.change_passwd
do
  sname=$(echo $name | sed 's/^eduid.\(.*\)$/\1/')
  tmux new-window -t $SESSION:$n -n $sname
  tmux send-keys -t $SESSION:$n "cd $name" Enter
  tmux send-keys -t $SESSION:$n "git pull" Enter
  tmux send-keys -t $SESSION:$n "if [ -d venv ]; then source venv/bin/activate; fi" Enter
  tmux send-keys -t $SESSION:$n "git status" Enter
  n=$(($n+1))
done

tmux send-keys -t $SESSION:1 "cd" Enter
tmux select-window -t $SESSION:1
tmux -2 attach -t $SESSION
