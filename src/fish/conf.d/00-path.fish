if functions -q fish_add_path
    fish_add_path $HOME/.local/bin
else
    set -Ux fish_user_paths $HOME/.local/bin $fish_user_paths
end
