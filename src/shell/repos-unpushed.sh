#!/usr/bin/env bash

# Lists repos with unpushed commits, unpushed tags or uncommitted changes,
# requires `ghq` to get the list of repositories

set -eu

# Plain SGR, not tput: tmux/screen sgr0 appends ^O (\017), which less -R shows literally
bold=$'\e[1m'
off=$'\e[0m'

indent() { sed 's/^/    /'; }

report() {
    local repo=$1 branch track log local_tags missing dirty

    # Commits not on any remote, per local branch
    while IFS=$'\t' read -r branch track; do
        log=$(git -C "$repo" log --oneline "refs/heads/$branch" --not --remotes)
        if [ -n "$log" ]; then
            echo "  branch $branch ${track:-[no upstream]}"
            indent <<<"$log"
        fi
    done < <(git -C "$repo" for-each-ref --format='%(refname:short)%09%(upstream:track)' refs/heads)

    # Tags missing from origin (needs network, so only asked when there are local tags)
    local_tags=$(git -C "$repo" for-each-ref --format='%(refname)' refs/tags | sort)
    if [ -n "$local_tags" ] && git -C "$repo" remote get-url origin >/dev/null 2>&1; then
        if remote_tags=$(git -C "$repo" ls-remote --tags --refs origin 2>/dev/null); then
            missing=$(comm -23 <(echo "$local_tags") <(cut -f2 <<<"$remote_tags" | sort) | sed 's|^refs/tags/||')
            if [ -n "$missing" ]; then
                echo "  tags not on origin"
                indent <<<"$missing"
            fi
        else
            echo "  tags: could not reach origin"
        fi
    fi

    dirty=$(git -C "$repo" status --short)
    if [ -n "$dirty" ]; then
        echo "  uncommitted"
        indent <<<"$dirty"
    fi
}

main() {
    while read -r repo; do
        out=$(report "$repo")
        if [ -n "$out" ]; then
            printf '%s\n%s\n\n' "${bold}${repo}${off}" "$out"
        fi
    done < <(ghq list --full-path)
}

# Page like git does: only on a terminal, and less -F exits if it fits one screen
if [ -t 1 ]; then
    # shellcheck disable=SC2086 # PAGER may carry arguments
    main | LESS=${LESS:-FRX} ${PAGER:-less}
else
    main
fi
