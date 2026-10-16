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
	@rm ${PREFIX}/genssh.sh \
		${PREFIX}/passphrase-generate-wordlist.sh \
		${PREFIX}/generate-gpg-key.sh \
		${PREFIX}/generate-ssh-key.sh \
		${PREFIX}/passphrase-generate-icloud-style.sh 2>/dev/null|| true
	@ln -f ${PREFIX}/rclone-pass-wrapper.sh ${PREFIX}/rclone

SHELL_TARGETS += scripts
