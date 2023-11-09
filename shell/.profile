# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

# Check for homebrew presence and add to PATH if detected
if [ -d "/opt/homebrew" ] ; then
	PATH=/opt/homebrew/bin:$PATH
fi
if [ -d "/home/linuxbrew/.linuxbrew" ] ; then
	eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

#define environmental vars
export GOPATH=$HOME/go
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH:$HOME/usr/bin:$HOME/.cargo/bin:$GOPATH/bin:$HOME/.local/bin/"
export EDITOR=helix

# Add crostool-ng cross compilers to PATH if present
if [ -d ~/x-tools ]; then
	for dir in ~/x-tools/*; do
		export PATH="$dir/bin":/$PATH
	done
fi


# Prepare pyenv if installed
if [ -x "$(command -v pyenv)" ]; then
	eval "$(pyenv init -)"
fi

# Make direnv shut up
export DIRENV_LOG_FORMAT=

if [ -e /home/user/.nix-profile/etc/profile.d/nix.sh ]; then . /home/user/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# TMATE Functions

TMATE_PAIR_NAME="$(whoami)-pair"
TMATE_SOCKET_LOCATION="/tmp/tmate-pair.sock"
TMATE_TMUX_SESSION="/tmp/tmate-tmux-session"

# Get current tmate connection url
tmate-url() {
  url="$(tmate -S $TMATE_SOCKET_LOCATION display -p '#{tmate_ssh}')"
  echo "$url" | tr -d '\n' | pbcopy
  echo "Copied tmate url for $TMATE_PAIR_NAME:"
  echo "$url"
}



# Start a new tmate pair session if one doesn't already exist
# If creating a new session, the first argument can be an existing TMUX session to connect to automatically
tmate-pair() {
  if [ ! -e "$TMATE_SOCKET_LOCATION" ]; then
    tmate -S "$TMATE_SOCKET_LOCATION" -f "$HOME/.tmate.conf" new-session -d -s "$TMATE_PAIR_NAME"

    while [ -z "$url" ]; do
      url="$(tmate -S $TMATE_SOCKET_LOCATION display -p '#{tmate_ssh}')"
    done
    tmate-url
    sleep 1

    if [ -n "$1" ]; then
      echo $1 > $TMATE_TMUX_SESSION
      tmate -S "$TMATE_SOCKET_LOCATION" send -t "$TMATE_PAIR_NAME" "TMUX='' tmux attach-session -t $1" ENTER
    fi
  fi
  tmate -S "$TMATE_SOCKET_LOCATION" attach-session -t "$TMATE_PAIR_NAME"
}



# Close the pair because security
tmate-unpair() {
  if [ -e "$TMATE_SOCKET_LOCATION" ]; then
    if [ -e "$TMATE_SOCKET_LOCATION" ]; then
      tmux detach -s $(cat $TMATE_TMUX_SESSION)
      rm -f $TMATE_TMUX_SESSION
    fi

    tmate -S "$TMATE_SOCKET_LOCATION" kill-session -t "$TMATE_PAIR_NAME"
    echo "Killed session $TMATE_PAIR_NAME"
  else
    echo "Session already killed"
  fi
}

# If running in a distrobox container, try to execute missing commands on the host
command_not_found_handle() {
  # don't run if not in a container
  if [ ! -e /run/.containerenv ] &&
  [ ! -e /.dockerenv ]; then
    exit 127
  fi

  if command -v flatpak-spawn >/dev/null 2>&1; then
   flatpak-spawn --host "${@}"
  elif command -v host-exec >/dev/null 2>&1; then
   host-exec "$@"
  else
    exit 127
  fi
}

if [ -n "${ZSH_VERSION-}" ]; then
   command_not_found_handler() {
     command_not_found_handle "$@"
  }
fi

# rustup and cargo
if [ -d ~/.cargo ]; then
	. "$HOME/.cargo/env"
fi

# Debug info
export DEBUGINFOD_URLS="https://debuginfod.elfutils.org/"
export DEBUGINFOD_PROGRESS=1
