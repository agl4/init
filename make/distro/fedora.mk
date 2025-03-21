PACKAGES += bash curl fish git gnupg-pkcs11-scd gnupg2 mosh pass pass-otp
PACKAGES += pcsc-lite pcsc-lite-ccid tmux rsync fzf git-lfs git-annex

fedora-upgrade :
	@sudo dnf upgrade -y

fedora-install :
	@sudo dnf install -y $(PACKAGES)

fedora-postinstall :
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

BASE_TARGETS += fedora-upgrade
BASE_TARGETS += fedora-install

ifndef INSIDE_DOCKER
BASE_TARGETS += fedora-postinstall
endif
