#!/usr/bin/env bash

#
# Use fzf to search the current pane's history and jump to the selected line in copy mode.
#

if [ -z "$TMUX" ] ; then
    echo "ERROR: This script must be run inside tmux."
    exit 1
fi

# the popup is not a pane, so this is the pane it was opened from
pane=$(tmux display -p '#{pane_id}')
hsize=$(tmux display -p -t "$pane" '#{history_size}')

line=$(tmux capture-pane -p -S - -t "$pane" |\
           # prefix each line with its 0-based index
           awk '{print NR-1 "\t" $0}' |\
           fzf --tac --no-sort --delimiter '\t' --with-nth 2.. |\
           cut -f1)

[ -n "$line" ] || exit 0

# goto-line N scrolls N lines up from the bottom; lines on the visible screen need cursor moves instead
offset=$((hsize - line))
down=0
if [ "$offset" -lt 0 ] ; then
    down=$((-offset))
    offset=0
fi

tmux copy-mode -t "$pane"
tmux send-keys -t "$pane" -X goto-line "$offset"
tmux send-keys -t "$pane" -X top-line
[ "$down" -gt 0 ] && tmux send-keys -t "$pane" -X -N "$down" cursor-down
exit 0
