#
# Source for configs:
#
# - https://makefiletutorial.com/#makefile-cookbook
# - https://lunarwatcher.github.io/posts/2024/01/06/how-to-set-up-a-makefile-for-managing-dotfiles-and-system-configurations.html
# - https://polothy.github.io/post/2018-10-09-makefile-dotfiles/
# - https://github.com/masasam/dotfiles/blob/master/Makefile
#
.PHONY : directories server desktop install base test all

SRCDIR := ./src
PREFIX ?= ${HOME}/.local/bin

OS := $(shell uname -s)

ifeq ($(OS),FreeBSD)
SHELL := /usr/local/bin/bash
else
SHELL := /bin/bash
endif

ARCHITECTURE := $(shell uname -m)
ifeq ($(OS),Linux)
DISTRIBUTION := $(shell source /etc/os-release && echo "$$ID")
VERSION_CODENAME := $(shell source /etc/os-release && echo "$$VERSION_CODENAME")
endif

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

# Default configuration
PACKAGES = curl fish git tmux bash
BASH_PREFIX := $(HOME)/.config/bash/conf.d
FISH_PREFIX := $(HOME)/.config/fish

# Include files:
-include make/os/$(OS).mk
-include make/distro/$(DISTRIBUTION).mk
include versions.mk
include make/base/fish.mk
include make/base/bash.mk
include make/base/git.mk
include make/base/gpg.mk
include make/base/scripts.mk
include make/base/ssh.mk
include make/base/tmux.mk
include make/server/ssh-server.mk

# Include apps
include make/apps/nodenv.mk
include make/apps/pyenv.mk
include make/apps/1password.mk
include make/apps/gh.mk
include make/apps/ghq.mk
include make/apps/resilio.mk
include make/apps/tailscale.mk
include make/apps/warp.mk

directories:
	@install -d -m 0700 "${HOME}/src"
	@install -d -m 0700 "${HOME}/tmp"

uninstall-asdf :
	rm -rf ${HOME}/.config/fish/conf.d/asdf.fish ${HOME}/.asdf/

base : install directories $(BASE_TARGETS)
server  : base $(SERVER_TARGETS)
desktop : base $(DESKTOP_TARGETS)
