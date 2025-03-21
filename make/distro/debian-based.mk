PACKAGES += bash curl fish git mosh pass pass-extension-otp
PACKAGES += rsync tmux fzf git-lfs git-annex ripgrep lsb-release

debian-update-repos :
	@sudo apt-get update -y

debian-upgrade : debian-update-repos
	@sudo apt-get upgrade -y

debian-install : debian-update-repos
	@sudo apt-get install -y $(PACKAGES)

debian-postinstall :
	@sudo apt-get install -y pcscd scdaemon gnupg2
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

BASE_TARGETS += debian-upgrade
BASE_TARGETS += debian-install

ifndef INSIDE_DOCKER
BASE_TARGETS += debian-postinstall
endif
