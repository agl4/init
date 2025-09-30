# Directories
GPG_DST_DIR := ${HOME}/.gnupg
GPG_SRC_DIR := ${SRCDIR}/gpg/conf

# Files to be installed
GPG_FILES := scdaemon.conf gpg.conf

# Pinentry must be set for macOS
GPG_FILES_AGENT := gpg-agent.conf
ifeq (${OS},Darwin)
GPG_FILES_AGENT := Darwin.gpg-agent.conf
endif

$(GPG_DST_DIR)/gpg-agent.conf: $(GPG_SRC_DIR)/${GPG_FILES_AGENT}
	@install -m 0600 -v $< $@

# Rule to install GPG configuration files
$(GPG_DST_DIR)/% : $(GPG_SRC_DIR)/%
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

# Target to install all GPG files
.PHONY : gpg
gpg : $(addprefix $(GPG_DST_DIR)/, $(GPG_FILES)) $(GPG_DST_DIR)/gpg-agent.conf

# Add gpg to desktop and help targets
SERVER_TARGETS += gpg
DESKTOP_TARGETS += gpg
