PACKAGES += bash curl fish git gnupg-pkcs11-scd gnupg2 mosh pass pass-otp
PACKAGES += pcsc-lite pcsc-lite-ccid tmux rsync

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
PACKAGES += bzip2 bzip2-devel gcc libffi-devel make openssl-devel
PACKAGES += readline-devel sqlite sqlite-devel tk-devel xz-devel zlib-devel

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

BASE_TARGETS += fedora-install fedora-postinstall