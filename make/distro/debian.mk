PACKAGES += bash curl fish git mosh pass pass-extension-otp
PACKAGES += rsync tmux fzf git-lfs git-annex ripgrep lsb-release
PACKAGES += openssh-server

.PHONY : debian-update-repos
debian-update-repos :
	@sudo apt-get update -y

.PHONY : debian-upgrade
debian-upgrade : debian-update-repos
	@sudo apt-get upgrade -y

.PHONY : debian-install
debian-install : debian-update-repos
	@sudo apt-get install -y $(PACKAGES)

.PHONY : debian-postinstall
debian-postinstall :
	@sudo apt-get install -y pcscd scdaemon gnupg2
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

INSTALL_TARGETS += debian-upgrade
INSTALL_TARGETS += debian-install

ifndef INSIDE_DOCKER
INSTALL_TARGETS += debian-postinstall
endif
