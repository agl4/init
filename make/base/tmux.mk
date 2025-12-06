${HOME}/.tmux.conf : ${SRCDIR}/tmux/conf/tmux.conf
	install -m 0600 -v $< $@

${PREFIX}/__tmux-switch-window.sh : ${SRCDIR}/tmux/bin/__tmux-switch-window.sh
	install -m 0700 -v $< $@

.PHONY : tmux
tmux: ${HOME}/.tmux.conf ${PREFIX}/__tmux-switch-window.sh

SHELL_TARGETS += tmux
