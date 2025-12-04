# Directories
SSH_SRC_DIR := ${SRCDIR}/ssh/conf
SSH_DST_DIR := ${HOME}/.ssh

# SSH Configurations
SSH_CONFIGS := $(wildcard ${SSH_SRC_DIR}/config ${SSH_SRC_DIR}/conf.d/*.conf)

# Rule to install SSH configurations
$(SSH_DST_DIR)/% : $(SSH_SRC_DIR)/%
	install -m 0700 -v -d $(dir $@)
	install -m 0600 -v $< $@

# Target to install all SSH configurations
.PHONY : ssh
ssh : $(addprefix $(SSH_DST_DIR)/, $(patsubst ${SSH_SRC_DIR}/%,%,${SSH_CONFIGS}))

# Add ssh to desktop and help targets
SHELL_TARGETS += fish
