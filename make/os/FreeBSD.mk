PACKAGES += bash curl fish git mosh rsync sudo tmux fzf


.PHONY : freebsd-pkg-update
freebsd-pkg-update :
	@pkg update -f

.PHONY : freebsd-pkg-upgrade
freebsd-pkg-upgrade :
	@export ASSUME_ALWAYS_YES=YES ; pkg upgrade -y
	@export PAGER=cat ; freebsd-update fetch install --not-running-from-cron

.PHONY : freebsd-base
freebsd-base : freebsd-pkg-update
	@pkg install -y $(PACKAGES)

BASE_TARGETS += freebsd-pkg-update
BASE_TARGETS += freebsd-pkg-upgrade
BASE_TARGETS += freebsd-base
