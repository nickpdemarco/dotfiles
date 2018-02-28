# My ugly way of having one bash_profile for work, and home - this checks if I'm on the corporate network.
if [[ $(hostname) = *"corp.adobe"* ]]; then
	# For work only
	ssh_key=id_git_corp_adobe_rsa; ssh_env=~/.ssh/agent.env; test -f "$ssh_env" && . "$ssh_env" >| /dev/null; agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?); if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then (umask 077; ssh-agent >| "$ssh_env"); . "$ssh_env" >| /dev/null; ssh-add ~/.ssh/$ssh_key; elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then ssh-add ~/.ssh/$ssh_key; fi; unset ssh_env; unset ssh_key;

	export P4USER=demarco
	export P4CLIENT=demarco-imac-workspace
	export P4PORT="ssl:catnip.corp.adobe.com:23000"

else
	# For home only

fi

# For both home and work.
alias=..='cd ..'
