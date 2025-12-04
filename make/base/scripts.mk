SCRIPTS := $(addprefix ${PREFIX}/,$(notdir $(wildcard ${SRCDIR}/shell/*.sh)))
$(SCRIPTS) : $(wildcard ${SRCDIR}/shell/*.sh)
	@install -m 0700 -v -d ${PREFIX}
	@install -m 0700 -v ${SRCDIR}/shell/$(notdir $@) $@
OS_SCRIPTS := $(addprefix ${PREFIX}/,$(notdir $(wildcard ${SRCDIR}/os/${OS}/*)))
$(OS_SCRIPTS) :
	@install -m 0700 -v -d "${PREFIX}"
	@install -m 0700 -v "${SRCDIR}/os/${OS}/$(notdir $@)" "$@"

.PHONY : scripts
scripts : $(SCRIPTS) $(OS_SCRIPTS)
	@ln -f ${PREFIX}/keys.sh ${PREFIX}/keys
	@ln -f ${PREFIX}/keys.sh ${PREFIX}/keys_week
	@rm ${PREFIX}/genssh.sh 2>/dev/null|| true
	@ln -f ${PREFIX}/pass-local.sh ${PREFIX}/pass-local

SHELL_TARGETS += scripts
