if functions -q fish_add_path
    fish_add_path $HOME/.local/bin
    fish_add_path /snap/bin
else
    set -Ux fish_user_paths /snap/bin $HOME/.local/bin $fish_user_paths
end
