# https://github.com/nodenv/nodenv#basic-github-checkout
set -Ux fish_user_paths $HOME/.nodenv/bin $fish_user_paths
status --is-interactive; and nodenv init - fish | source
