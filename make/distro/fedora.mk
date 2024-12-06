PACKAGES += bash curl fish git gnupg-pkcs11-scd gnupg2 mosh pass pass-otp
PACKAGES += pcsc-lite pcsc-lite-ccid tmux rsync fzf emacs git-lfs git annex 
PACKAGES += hunspell hunspell-hu hunspell-en-GB hunspell-en-US ripgrep

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
PACKAGES += bzip2 bzip2-devel gcc libffi-devel make openssl-devel
PACKAGES += readline-devel sqlite sqlite-devel tk-devel xz-devel zlib-devel
PACKAGES += unzip

fedora-upgrade :
	@sudo dnf upgrade -y

fedora-install :
	@sudo dnf install -y $(PACKAGES)

fedora-postinstall :
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

ifndef INSTALL_FAST
COMMON_TARGETS += fedora-upgrade
endif

COMMON_TARGETS += fedora-install

ifndef INSIDE_DOCKER
COMMON_TARGETS += fedora-postinstall
endif
