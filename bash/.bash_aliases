# Make aliases
# Apparently "mt" would conflict with a command for managing tape drives...
alias tt="make test |& less"


# Tmux aliases

#start tmux
#if not inside a tmux session, and if no session is started, start a new session
alias st=runtmux

runtmux() {
	if which tmux >/dev/null 2>&1; then
		test -z "$TMUX" && (tmux attach || tmux new-session)
	fi
}
