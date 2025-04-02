# https://github.com/nodenv/nodenv#basic-github-checkout
if functions -q fish_add_path
    fish_add_path $HOME/.nodenv/bin
else
    set -Ux fish_user_paths $fish_user_paths
end

if test -x $HOME/.nodenv/bin/nodenv
    status --is-interactive; and nodenv init - fish | source
end
