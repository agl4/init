# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
# https://github.com/pyenv/pyenv?tab=readme-ov-file#b-set-up-your-shell-environment-for-pyenv

PYENV_VERSION := $(shell cat share/pyenv/.python-version)

pyenv-deps-darwin :
	@brew install openssl readline sqlite3 xz zlib tcl-tk@8 libb2

pyenv-deps-ubuntu :
	@sudo apt update ; sudo apt install -y build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev curl git \
		libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

pyenv-deps-fedora :
	@sudo dnf install -y make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2

pyenv-deps-opensuse :
	@sudo zypper install -y gcc automake bzip2 libbz2-devel xz xz-devel openssl-devel ncurses-devel readline-devel zlib-devel tk-devel libffi-devel sqlite3-devel gdbm-devel make findutils patch

pyenv-setup-bashrc :
	grep ^export\ PYENV_ROOT ${HOME}/.bashrc || echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> ${HOME}/.bashrc
	grep 'PYENV_ROOT.*PATH' ${HOME}/.bashrc || echo '[[ -d $$PYENV_ROOT/bin ]] && export PATH="$$PYENV_ROOT/bin:$$PATH"' >> ${HOME}/.bashrc
	grep 'pyenv\ init' ${HOME}/.bashrc || echo 'eval "$$(pyenv init - bash)"' >> ${HOME}/.bashrc

pyenv-setup-zshrc :
	grep ^export\ PYENV_ROOT ${HOME}/.zshrc || echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> ${HOME}/.zshrc
	grep 'PYENV_ROOT.*PATH' ${HOME}/.zshrc || echo '[[ -d $$PYENV_ROOT/bin ]] && export PATH="$$PYENV_ROOT/bin:$$PATH"' >> ${HOME}/.zshrc
	grep 'pyenv\ init' ${HOME}/.zshrc || echo 'eval "$$(pyenv init - zsh)"' >> ${HOME}/.zshrc

pyenv-install :
	@git clone https://github.com/pyenv/pyenv.git ${HOME}/.pyenv || git -C ${HOME}/.pyenv pull
	echo $(PYENV_VERSION) ${PYENV_VERSION}
	. ${HOME}/.bashrc && \
		pyenv install --skip-existing ${PYENV_VERSION} &&\
		pyenv global ${PYENV_VERSION} &&\
		pip install --upgrade pip &&\
		pip install -r share/pyenv/requirements.txt


PYENV_TARGETS += pyenv-setup-bashrc pyenv-setup-zshrc

ifeq (${OS},Darwin)
PYENV_TARGETS += pyenv-deps-darwin
endif
ifneq (${OS},Darwin)
PYENV_TARGETS += pyenv-deps-${DISTRIBUTION}
endif

pyenv: $(PYENV_TARGETS) pyenv-install
DESKTOP_TARGETS += pyenv
