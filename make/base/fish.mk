.PHONY: fisher_update fish

# Directories
FISH_PREFIX := $(HOME)/.config/fish
FISH_DIR_SRC := $(SRCDIR)/fish

# Fisher components
FISHER := functions completions

# Fish configuration files
FISH_FILES := $(wildcard ${FISH_DIR_SRC}/config.fish ${FISH_DIR_SRC}/fish_plugins ${FISH_DIR_SRC}/conf.d/* ${FISH_DIR_SRC}/completions/* ${FISH_DIR_SRC}/functions/* )

# Rule to install fish configuration files
$(FISH_PREFIX)/%: $(FISH_DIR_SRC)/%
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

# Target to install all fish configuration files
fish_install: $(addprefix $(FISH_PREFIX)/, $(patsubst ${FISH_DIR_SRC}/%,%,${FISH_FILES}))

# Rule to install Fisher components
$(FISHER):
	@install -m 0700 -d -v $(FISH_PREFIX)/$@
	@curl -sSL "https://raw.githubusercontent.com/jorgebucaran/fisher/$(FISHER_VERSION)/$@/fisher.fish" > $(FISH_PREFIX)/$@/fisher.fish

# Target to update Fisher
fisher_update:
	@fish -c "fisher update"

# Main target to install fish and update Fisher
fish: $(FISHER) fish_install fisher_update
	@echo "Fish installed."

# Common and help targets
DESKTOP_TARGETS += fish
SERVER_TARGETS += fish
