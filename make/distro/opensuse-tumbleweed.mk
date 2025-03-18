PACKAGES += bash curl fish git gnupg-pkcs11-scd gnupg2 mosh pass pass-otp
PACKAGES += pcsc-lite pcsc-lite-ccid tmux rsync fzf emacs git-lfs git-annex
PACKAGES += hunspell hunspell-hu hunspell-en-GB hunspell-en-US ripgrep

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
PACKAGES += bzip2 bzip2-devel gcc libffi-devel make openssl-devel
PACKAGES += readline-devel sqlite sqlite-devel tk-devel xz-devel zlib-devel
PACKAGES += unzip

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
