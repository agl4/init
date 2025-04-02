PACKAGES += bash curl fish git gnupg-pkcs11-scd gnupg2 mosh pass pass-otp
PACKAGES += pcsc-lite pcsc-lite-ccid tmux rsync fzf git-lfs git-annex

.PHONY : fedora-upgrade
fedora-upgrade :
	@sudo dnf upgrade -y

.PHONY : fedora-install
fedora-install :
	@sudo dnf install -y $(PACKAGES)

.PHONY : fedora-postinstall
fedora-postinstall :
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

BASE_TARGETS += fedora-upgrade
BASE_TARGETS += fedora-install

ifndef INSIDE_DOCKER
BASE_TARGETS += fedora-postinstall
endif
