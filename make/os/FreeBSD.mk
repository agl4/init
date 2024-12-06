.PHONY : freebsd-pkg-update freebsd-pkg-upgrade freebsd-base

PACKAGES += bash curl fish git mosh rsync sudo tmux fzf
PACKAGES += hunspell en-hunspell hu-hunspell hs-git-annex

freebsd-pkg-update :
	@pkg update -f

freebsd-pkg-upgrade :
	@export ASSUME_ALWAYS_YES=YES ; pkg upgrade -y
	@export PAGER=cat ; freebsd-update fetch install --not-running-from-cron

freebsd-base : freebsd-pkg-update
	@pkg install -y $(PACKAGES)


ifndef INSTALL_FAST
COMMON_TARGETS += freebsd-pkg-update
COMMON_TARGETS += freebsd-pkg-upgrade
endif
COMMON_TARGETS += freebase-base
