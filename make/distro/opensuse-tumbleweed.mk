PACKAGES += bash curl fish git gpg2 mosh password-store
PACKAGES += pcsc-lite pcsc-ccid tmux rsync fzf git-lfs git-annex
PACKAGES += openssh-server gawk tar

.PHONY : opensuse-tumbleweed-upgrade
opensuse-tumbleweed-upgrade :
	@sudo zypper update -y

.PHONY : opensuse-tumbleweed-install
opensuse-tumbleweed-install :
	@sudo zypper install -y $(PACKAGES)

.PHONY : opensuse-tumbleweed-postinstall
opensuse-tumbleweed-postinstall :
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

INSTALL_TARGETS += opensuse-tumbleweed-upgrade
INSTALL_TARGETS += opensuse-tumbleweed-install

ifndef INSIDE_DOCKER
INSTALL_TARGETS += opensuse-tumbleweed-postinstall
endif
