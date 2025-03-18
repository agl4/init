PACKAGES += bash curl fish git gpg2 mosh password-store
PACKAGES += pcsc-lite pcsc-ccid tmux rsync fzf emacs git-lfs git-annex
PACKAGES += hunspell  ripgrep

opensuse-tumbleweed-upgrade :
	@sudo zypper update -y

opensuse-tumbleweed-install :
	@sudo zypper install -y $(PACKAGES)

opensuse-tumbleweed-postinstall :
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

ifndef INSTALL_FAST
BASE_TARGETS += opensuse-tumbleweed-upgrade
endif

BASE_TARGETS += opensuse-tumbleweed-install

ifndef INSIDE_DOCKER
BASE_TARGETS += opensuse-tumbleweed-postinstall
endif
