PACKAGES += bash curl fish git mosh
PACKAGES += rsync tmux fzf git-lfs git-annex ripgrep lsb-release
PACKAGES += openssh-server cryptsetup udisks2 golang-go gopass gopass-archive-keyring

# Key fingerprint 8086459860A915BA78CAAB6A686E9DE6E1AEFFBE
GOPASS_KEYRING_SHA256 := 01bb162443f88415ec53093e5b2b466efb29bdcaecd247ae194d816ae7576bc7

.PHONY : debian-gopass-repo
debian-gopass-repo :
	@tmp=$$(mktemp) && trap 'rm -f "$$tmp"' EXIT && \
		curl -fsSL https://packages.gopass.pw/repos/gopass/gopass-archive-keyring.gpg -o "$$tmp" && \
		echo "$(GOPASS_KEYRING_SHA256)  $$tmp" | sha256sum -c --quiet - && \
		sudo install -m 0644 "$$tmp" /usr/share/keyrings/gopass-archive-keyring.gpg
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
	-@sudo apt-get remove -y $(PACKAGES_REMOVE)
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
