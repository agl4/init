BREW_CONFIG_SRC := share/homebrew

UNAME_M := $(shell uname -m)
BREW := /opt/homebrew/bin/brew
ifeq ($(UNAME_M),x86_64)
BREW := /usr/local/bin/brew
endif

PACKAGES += curl fish git gnupg mosh openssh pass pass-otp tmux fzf git-lfs git-annex
PACKAGES += sqlite3 ripgrep hunspell unzip
PACKAGES_CASKS := gpg-suite-no-mail emacs

$(BREW) :
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

darwin-brew-update : | $(BREW)
	@${BREW} update

darwin-brew-upgrade : | $(BREW)
	@${BREW} update

darwin-base : | $(BREW)
	@${BREW} install $(PACKAGES)
	@${BREW} install --cask $(PACKAGES_CASKS)

$(BASH_PREFIX)/conf.d/homebrew.bash : ${BREW_CONFIG_SRC}/homebrew.bash
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

$(FISH_PREFIX)/conf.d/homebrew.fish : ${BREW_CONFIG_SRC}/homebrew.fish
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

brew-setup-shell : $(BASH_PREFIX)/conf.d/homebrew.bash $(FISH_PREFIX)/conf.d/homebrew.fish

BASE_TARGETS += brew-setup-shell
BASE_TARGETS += darwin-brew-update
BASE_TARGETS += darwin-brew-upgrade
BASE_TARGETS += darwin-base
