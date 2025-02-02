PACKAGES += bash curl fish git gnupg2 mosh pass pass-extension-otp pcscd
PACKAGES += rsync scdaemon tmux fzf emacs git-lfs git-annex ripgrep
PACKAGES += hunspell hunspell-hu hunspell-en-gb hunspell-en-us

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
PACKAGES += build-essential curl libbz2-dev libffi-dev liblzma-dev
PACKAGES += libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev
PACKAGES += libxml2-dev libxmlsec1-dev llvm make tk-dev wget xz-utils zlib1g-dev
PACKAGES += unzip openssh-server

debian-update-repos :
	@sudo apt-get update -y

debian-upgrade : debian-update-repos
	@sudo apt-get upgrade -y

debian-install : debian-update-repos
	@sudo apt-get install -y $(PACKAGES)

debian-postinstall :
	@sudo systemctl enable pcscd
	@sudo systemctl start pcscd

ifndef INSTALL_FAST
BASE_TARGETS += debian-upgrade
endif

BASE_TARGETS += debian-install

ifndef INSIDE_DOCKER
BASE_TARGETS += debian-postinstall
endif
