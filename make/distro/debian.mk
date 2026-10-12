PACKAGES += bash curl fish git mosh pass pass-extension-otp
PACKAGES += rsync tmux fzf git-lfs git-annex ripgrep lsb-release
PACKAGES += openssh-server cryptsetup udisks2 golang-go gopass gopass-archive-keyring

.PHONY : debian-gopass-repo
debian-gopass-repo :
	@curl -fsSL https://packages.gopass.pw/repos/gopass/gopass-archive-keyring.gpg | sudo tee /usr/share/keyrings/gopass-archive-keyring.gpg > /dev/null
	@printf '%s\n' \
		'Types: deb' \
		'URIs: https://packages.gopass.pw/repos/gopass' \
		'Suites: stable' \
		'Architectures: all amd64 arm64 armhf' \
		'Components: main' \
		'Signed-By: /usr/share/keyrings/gopass-archive-keyring.gpg' \
		| sudo tee /etc/apt/sources.list.d/gopass.sources > /dev/null

.PHONY : debian-update-repos
debian-update-repos : debian-gopass-repo
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
