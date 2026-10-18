BREW_CONFIG_SRC := share/homebrew

UNAME_M := $(shell uname -m)
BREW := /opt/homebrew/bin/brew
ifeq ($(UNAME_M),x86_64)
BREW := /usr/local/bin/brew
endif

PACKAGES += curl fish git gnupg mosh openssh tmux fzf git-lfs git-annex
PACKAGES += sqlite3 ripgrep hunspell unzip pinentry-mac gopass
PACKAGES_CASKS := emacs-app

export NONINTERACTIVE := 1
unexport HOMEBREW_ASK

$(BREW) :
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

.PHONY : darwin-brew-update
darwin-brew-update : | $(BREW)
	@${BREW} update

.PHONY : darwin-brew-upgrade
darwin-brew-upgrade : | $(BREW)
	@${BREW} update

.PHONY : darwin-base
darwin-base : | $(BREW)
	-@${BREW} uninstall $(PACKAGES_REMOVE)
	@${BREW} install $(PACKAGES)
	@${BREW} install --cask $(PACKAGES_CASKS)

$(BASH_PREFIX)/conf.d/homebrew.bash : ${BREW_CONFIG_SRC}/homebrew.bash
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

$(FISH_PREFIX)/conf.d/homebrew.fish : ${BREW_CONFIG_SRC}/homebrew.fish
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

.PHONY : brew-setup-shell
brew-setup-shell : $(BASH_PREFIX)/conf.d/homebrew.bash $(FISH_PREFIX)/conf.d/homebrew.fish

INSTALL_TARGETS += brew-setup-shell
INSTALL_TARGETS += darwin-brew-update
INSTALL_TARGETS += darwin-brew-upgrade
INSTALL_TARGETS += darwin-base
