# Directories
BASH_DIR_SRC := $(SRCDIR)/bash/conf.d/
BASH_FILES := $(wildcard ${BASH_DIR_SRC}/*)

$(BASH_PREFIX)/conf.d/%: $(BASH_DIR_SRC)/%
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

.PHONY : bash_install
bash_install : $(addprefix $(BASH_PREFIX)/conf.d/, $(patsubst ${BASH_DIR_SRC}/%,%,${BASH_FILES}))
	@install -m 0700 -d -v ${BASH_PREFIX}/conf.d

.PHONY : insert_bashrc_loader
insert_bashrc_loader :
	@grep -q '^while read -r BASHRC' ${HOME}/.bashrc ||\
		echo 'while read -r BASHRC ; do source "$$BASHRC" ; done < <(find "${BASH_PREFIX}/conf.d" -type f -name "*.bash")' >> ${HOME}/.bashrc

# Main target to install fish and update Fisher
.PHONY : bash
bash : bash_install insert_bashrc_loader

# Common and help targets
SHELL_TARGETS += bash
