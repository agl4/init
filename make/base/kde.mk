${HOME}/.config/plasma-workspace/env/ssh-agent.sh :
	mkdir -p $(shell dirname $@) || true
	install -m 0600 ${SRCDIR}/kde/ssh-agent.sh $@


kde : ${HOME}/.config/plasma-workspace/env/ssh-agent.sh

DESKTOP_TARGETS += kde
