# https://github.com/pyenv/pyenv?tab=readme-ov-file#b-set-up-your-shell-environment-for-pyenv
set -Ux PYENV_ROOT $HOME/.pyenv

if functions -q fish_add_path
    fish_add_path $PYENV_ROOT/bin
else
    set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths
end

if test -x $PYENV_ROOT/bin/pyenv
    pyenv init - fish | source
end
