#!/bin/sh
set -e

logdir="$HOME/.cache/tmux"
mkdir -p "$logdir"

timestamp=$(date "+%F_%T")
logfile="$logdir/tmux.$timestamp:#H.#S:#I:#W:#P.log"

# See https://nicokrieger.de/trick-tmux-into-auto-logging/
tmux pipe-pane -o "cat >>$logfile"
