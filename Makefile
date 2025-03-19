#
# Source for configs:
#
# - https://makefiletutorial.com/#makefile-cookbook
# - https://lunarwatcher.github.io/posts/2024/01/06/how-to-set-up-a-makefile-for-managing-dotfiles-and-system-configurations.html
# - https://polothy.github.io/post/2018-10-09-makefile-dotfiles/
# - https://github.com/masasam/dotfiles/blob/master/Makefile
#
.PHONY : caps-lock dev directories server desktop install base test all

SHELL := /bin/bash
OS := $(shell uname -s)
ARCHITECTURE := $(shell uname -m)
ifeq ($(OS),Linux)
DISTRIBUTION := $(shell source /etc/os-release && echo "$$ID")
VERSION_CODENAME := $(shell cat /etc/os-release | sed -n 's/^VERSION_CODENAME=\(.*\)$$/\1/p')
endif
SRCDIR := ./src
PREFIX ?= ${HOME}/.local/bin

# INSIDE_DOCKER := $(or $(and $(wildcard /.dockerenv),1),0)
ifneq ($(wildcard /.dockerenv),)
    # .dockerenv file exists
    INSIDE_DOCKER := 1
else
    # .dockerenv file does not exist
    # INSIDE_DOCKER remains undefined
endif

HOST := $(shell hostname)
# Debug information
$(info -- Running on host.........: $(HOST))
$(info -- Detected OS.............: $(OS))
$(info -- Detected distribution...: $(DISTRIBUTION))
$(info -- Version codename .......: $(VERSION_CODENAME))
$(info -- Architecture ...........: $(ARCHITECTURE))
$(info -- Inside docker ..........: $(INSIDE_DOCKER))

# Target definitions
BASE_TARGETS :=
SERVER_TARGETS :=
DESKTOP_TARGETS :=
ASDF_TARGETS :=
PACKAGES = curl fish git tmux

# Include files:
-include make/os/$(OS).mk
-include make/distro/$(DISTRIBUTION).mk
include versions.mk
include make/fish.mk
include make/git.mk
include make/gpg.mk
include make/nodenv.mk
include make/pyenv.mk
include make/ssh-server.mk
include make/ssh.mk
include make/tmux.mk

# Include apps
include make/apps/1password.mk
include make/apps/gh.mk
include make/apps/ghq.mk
include make/apps/resilio.mk
include make/apps/tailscale.mk
include make/apps/warp.mk

dev :
	@install -m 0700 "share/commit-hook.sh" .git/hooks/prepare-commit-msg

directories:
	@install -d -m 0700 "${HOME}/src"
	@install -d -m 0700 "${HOME}/tmp"

caps-lock :
	@gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:nocaps']"

SCRIPTS := $(addprefix ${PREFIX}/,$(notdir $(wildcard ${SRCDIR}/shell/*.sh)))
$(SCRIPTS) : $(wildcard ${SRCDIR}/shell/*.sh)
	@install -m 0700 -v -d ${PREFIX}
	@install -m 0700 -v ${SRCDIR}/shell/$(notdir $@) $@
OS_SCRIPTS := $(addprefix ${PREFIX}/,$(notdir $(wildcard ${SRCDIR}/os/${OS}/*)))
$(OS_SCRIPTS) :
	@install -m 0700 -v -d "${PREFIX}"
	@install -m 0700 -v "${SRCDIR}/os/${OS}/$(notdir $@)" "$@"

install : $(SCRIPTS) $(OS_SCRIPTS)
	@ln -f ${PREFIX}/keys.sh ${PREFIX}/keys
	@ln -f ${PREFIX}/keys.sh ${PREFIX}/keys_week

uninstall :
	rm $(SCRIPTS) $(OS_SCRIPTS) ${PREFIX}/keys ${PREFIX}/keys_week

uninstall-asdf :
	rm -rf ${HOME}/.config/fish/conf.d/asdf.fish ${HOME}/.asdf/

base : install directories $(BASE_TARGETS)
server  : base $(SERVER_TARGETS)
desktop : base $(DESKTOP_TARGETS)

test :
	fish --version
	git --version
	gpg --version
	node --version
	pass --version
	python --version
	tmux -V
	type python | grep pyenv
	type node | grep nodenv
