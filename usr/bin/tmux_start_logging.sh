#!/bin/sh
set -e

logdir="$HOME/.cache/tmux"
mkdir -p "$logdir"

timestamp=$(date "+%F_%T")
# Panes are started in quick succession by e.g. tmuxinator.
# To prevent them logging into the same file, append a random slug to the name
slug=$(tr -dc A-Za-z0-9 </dev/random | head -c 8; echo)
logfile="$logdir/tmux.$timestamp:#H.#S:#I:#W:#P:$slug.log"

# See https://nicokrieger.de/trick-tmux-into-auto-logging/
tmux pipe-pane -o "cat >>$logfile"
