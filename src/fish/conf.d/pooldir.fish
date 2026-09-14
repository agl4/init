# Default root for pooldir; override by setting POOLDIR_ROOT (e.g. in
# config.fish or as a universal variable).
set -q POOLDIR_ROOT; or set -g POOLDIR_ROOT $HOME/share/pool2

function __pooldir
    pooldir $argv
end

if test "$fish_key_bindings" = fish_vi_key_bindings
    bind -M insert \co __pooldir
end
