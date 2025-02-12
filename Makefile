#
# Source for configs:
#
# - https://makefiletutorial.com/#makefile-cookbook
# - https://lunarwatcher.github.io/posts/2024/01/06/how-to-set-up-a-makefile-for-managing-dotfiles-and-system-configurations.html
# - https://polothy.github.io/post/2018-10-09-makefile-dotfiles/
# - https://github.com/masasam/dotfiles/blob/master/Makefile
#

OS := $(shell uname -s)
ARCHITECTURE := $(shell uname -m)
ifeq ($(OS),Linux)
DISTRIBUTION := $(shell cat /etc/os-release | sed -n 's/^ID=\(.*\)$$/\1/p')
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
$(info -- Version codename .......: $(ARCHITECTURE))
$(info -- Inside docker ..........: $(INSIDE_DOCKER))

# Target definitions
BASE_TARGETS :=
SERVER_TARGETS :=
DESKTOP_TARGETS :=
ASDF_TARGETS :=
PACKAGES = curl fish git tmux

# ... other variable declarations
-include make/os/$(OS).mk
-include make/distro/$(DISTRIBUTION).mk
include versions.mk
include make/apps/1password.mk
include make/apps/asdf.mk
include make/apps/fish.mk
include make/apps/gh.mk
include make/apps/git.mk
include make/apps/gpg.mk
include make/apps/resilio.mk
include make/apps/ssh-server.mk
include make/apps/ssh.mk
include make/apps/tailscale.mk
include make/apps/tmux.mk
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

server  : install directories $(BASE_TARGETS) $(SERVER_TARGETS)
desktop : install directories $(BASE_TARGETS) $(DESKTOP_TARGETS)

apps : directories $(GH_TARGETS) $(1PASSWORD_TARGETS) $(RESILIO_TARGETS) $(TAILSCALE_TARGETS) $(WARP_TARGETS);

.PHONY : apps caps-lock dev directories server desktop install

test :
	fish --version
	git --version
	gpg --version
	node --version
	pass --version
	python --version
	tmux -V
