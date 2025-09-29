# Configure git

# https://blog.gitbutler.com/how-git-core-devs-configure-git/

GIT_GLOBAL_CONFIG := ${HOME}/.config/git/config

.PHONY : git
git :
	@if [ -e ${HOME}/.gitconfig ] ; then mv ${HOME}/.gitconfig ${HOME}/.gitconfig.bak ; fi
	@mkdir -p $(shell dirname ${GIT_GLOBAL_CONFIG}) || true
	@touch ${GIT_GLOBAL_CONFIG}
	@git config --global pull.rebase "false"
	@git config --global credential.helper cache
	@git config --global core.autocrlf "false"
	@git config --global core.fsmonitor "false"
	@git config --global diff.gpg.textconv "gpg --no-tty --decrypt"
	@git config --global init.defaultBranch main

	@git config --global column.ui auto
	@git config --global branch.sort -committerdate
	@git config --global tag.sort version:refname
	@git config --global diff.algorithm histogram
	@git config --global diff.colorMoved plain
	@git config --global diff.mnemonicPrefix true
	@git config --global diff.renames true
	@git config --global commit.verbose true
	@git config --global merge.conflictstyle zdiff3

	@git config --global alias.root "rev-parse --show-toplevel"
	@git config --global alias.b "branch"
	@git config --global alias.ba "branch -av"
	@git config --global alias.d "diff"
	@git config --global alias.l "log"
	@git config --global alias.lg "log --graph"
	@git config --global alias.l1 "log --oneline"
	@git config --global alias.l1g "log --oneline --graph"
	@git config --global alias.r "remote"
	@git config --global alias.f "fetch"
	@git config --global alias.p "pull"
	@git config --global alias.s "status"
	@git config --global alias.s1 "status --short"
	@git config --global alias.exec "!exec "
	@git config --global alias.o "count-objects -vH"

	@git config --global filter.lfs.clean "git-lfs clean -- %f"
	@git config --global filter.lfs.smudge "git-lfs smudge -- %f"
	@git config --global filter.lfs.process "git-lfs filter-process"
	@git config --global filter.lfs.required "true"

	@git config --global credential.https://github.com.username "agl4"
	@git config --global credential.https://github.com.helper !'${HOME}/.local/bin/pass-git-credential-helper.sh'

	@install -m 0700 -d -v "${HOME}/src"
	@git config --global ghq.root "${HOME}/src"

# Add targets to groups
DESKTOP_TARGETS += git
SERVER_TARGETS += git
