.PHONY : freebsd-pkg-update freebsd-pkg-upgrade freebsd-base

PACKAGES += bash curl fish git mosh rsync sudo tmux fzf

freebsd-pkg-update :
	@pkg update -f

freebsd-pkg-upgrade :
	@export ASSUME_ALWAYS_YES=YES ; pkg upgrade -y
	@export PAGER=cat ; freebsd-update fetch install --not-running-from-cron

freebsd-base : freebsd-pkg-update
	@pkg install -y $(PACKAGES)

BASE_TARGETS += freebsd-pkg-update
BASE_TARGETS += freebsd-pkg-upgrade
BASE_TARGETS += freebsd-base
