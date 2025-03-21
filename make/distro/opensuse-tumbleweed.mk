PACKAGES += bash curl fish git gpg2 mosh password-store
PACKAGES += pcsc-lite pcsc-ccid tmux rsync fzf git-lfs git-annex

opensuse-tumbleweed-upgrade :
	@sudo zypper update -y

opensuse-tumbleweed-install :
	@sudo zypper install -y $(PACKAGES)

opensuse-tumbleweed-postinstall :
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

BASE_TARGETS += opensuse-tumbleweed-upgrade
BASE_TARGETS += opensuse-tumbleweed-install

ifndef INSIDE_DOCKER
BASE_TARGETS += opensuse-tumbleweed-postinstall
endif
