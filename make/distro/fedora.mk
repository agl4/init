PACKAGES += bash curl fish git gnupg-pkcs11-scd gnupg2 mosh pass pass-otp
PACKAGES += pcsc-lite pcsc-lite-ccid tmux rsync fzf emacs git-lfs git-annex
PACKAGES += hunspell hunspell-hu hunspell-en-GB hunspell-en-US ripgrep

fedora-upgrade :
	@sudo dnf upgrade -y

fedora-install :
	@sudo dnf install -y $(PACKAGES)

fedora-postinstall :
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

ifndef INSTALL_FAST
BASE_TARGETS += fedora-upgrade
endif

BASE_TARGETS += fedora-install

ifndef INSIDE_DOCKER
BASE_TARGETS += fedora-postinstall
endif
