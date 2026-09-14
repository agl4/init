function pooldir -d "Get or create a directory in a root (argv, or \$POOLDIR_ROOT)."
    argparse 'm/maxdepth=' -- $argv
    or return

    set -q TMPDIR; or set -l TMPDIR /tmp/
    set -q _flag_maxdepth; or set -l _flag_maxdepth 1

    # root(s): explicit arguments win, otherwise fall back to $POOLDIR_ROOT
    if test (count $argv) -eq 0
        if not set -q POOLDIR_ROOT[1]
            echo "pooldir: no root given and POOLDIR_ROOT is not set" >&2
            return 1
        end
        set argv $POOLDIR_ROOT
    end

    # make find command work on both platforms correctly
    set -l depth_option -depth
    if test (uname -s) = Linux
        set depth_option -maxdepth
    end

    set -l subdir
    set -l query
    command find $argv -mindepth 1 "$depth_option" "$_flag_maxdepth" -type d | sort -n | eval "fzf --no-multi --print-query $POOLDIR_FZF_OPTIONS" \
        | while read -l r
        # store the query
        if test -z "$query"
            set query $r
            # store the subdir
        else
            set subdir $r
        end
    end

    # exit if user canceled
    if test -z "$query"; and test -z "$subdir"
        commandline -f repaint
        return
    end

    if test -z $subdir
        if test -d $query
            # In this case there was a valid result but no query was typed in,
            # possibly because of arrow-key selecting in results.
            commandline -it -- (string trim "$query")
        else
            # Here query was typed in, but no directories matched, so create
            # one.
            set -l basedir (string trim "$query" | sed 's/[^[a-z0-9]/-/ig')
            set -l fulldir $argv[1]/(date +%Y%m%d)-$basedir
            mkdir -p (string trim "$fulldir")
            commandline -it -- (string trim "$fulldir")
        end
    else
        commandline -it -- (string trim "$subdir")
    end
end
