SSH_SRC := ./src/ssh-server
SSH_TARGET := /etc/ssh

ifeq ($(GITHUB_ACTIONS),)
SSH_CONFIGS := sshd_config TrustedUserCAKeys
else
SSH_CONFIGS := sshd_config_github_actions TrustedUserCAKeys
endif

SSH_TARGETS := $(subst ${SSH_SRC},${SSH_TARGET},$(SSH_CONFIGS))

$(SSH_TARGET)/%: $(SSH_SRC)/%
	sudo install -m 0600 -v $< $@
ifeq (${OS},Linux)
	sudo systemctl enable ssh
	sudo systemctl restart ssh
endif
ifeq (${OS},FreeBSD)
	sysrc sshd_enable="YES"
	service sshd restart
endif

.PHONY : ssh-server
ssh-server : $(addprefix $(SSH_TARGET)/, $(SSH_CONFIGS))

SERVER_TARGETS += ssh-server
