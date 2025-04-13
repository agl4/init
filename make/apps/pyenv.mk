# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
# https://github.com/pyenv/pyenv?tab=readme-ov-file#b-set-up-your-shell-environment-for-pyenv

PYENV_VERSION := $(shell cat share/app-pyenv/.python-version)
PYENV_CONFIG_SRC := share/app-pyenv
PYENV_DEFAULT_PACKAGES := ${PYENV_CONFIG_SRC}/requirements.txt

.PHONY : pyenv-deps-darwin
pyenv-deps-darwin :
	@brew install openssl readline sqlite3 xz zlib tcl-tk@8 libb2

.PHONY : pyenv-deps-ubuntu
pyenv-deps-ubuntu :
	@sudo apt-get update ; sudo apt-get install -y build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev curl git \
		libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

.PHONY : pyenv-deps-fedora
pyenv-deps-fedora :
	@sudo dnf install -y make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2 gawk

.PHONY : pyenv-deps-opensuse-tumbleweed
pyenv-deps-opensuse-tumbleweed :
	@sudo zypper install -y gcc automake bzip2 libbz2-devel xz xz-devel openssl-devel ncurses-devel \
		readline-devel zlib-devel tk-devel libffi-devel sqlite3-devel gdbm-devel make findutils patch

.PHONY : pyenv-install
pyenv-install :
	@git clone https://github.com/pyenv/pyenv.git ${HOME}/.pyenv || git -C ${HOME}/.pyenv pull
	${HOME}/.pyenv/bin/pyenv install --skip-existing ${PYENV_VERSION}
	${HOME}/.pyenv/bin/pyenv global ${PYENV_VERSION}
	${HOME}/.pyenv/shims/pip install --upgrade pip
	${HOME}/.pyenv/shims/pip install -r ${PYENV_DEFAULT_PACKAGES}
	${HOME}/.pyenv/bin/pyenv rehash

$(BASH_PREFIX)/conf.d/pyenv.bash : ${PYENV_CONFIG_SRC}/pyenv.bash
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

$(FISH_PREFIX)/conf.d/pyenv.fish : ${PYENV_CONFIG_SRC}/pyenv.fish
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

.PHONY : pyenv-setup-shell
pyenv-setup-shell : $(BASH_PREFIX)/conf.d/pyenv.bash $(FISH_PREFIX)/conf.d/pyenv.fish

.PHONY : pyenv-darwin-path-setup
pyenv-darwin-path-setup :
	sudo mkdir -p /etc/paths.d || true
	echo "${HOME}/.pyenv/bin" | sudo tee /etc/paths.d/pyenv
	echo "${HOME}/.pyenv/shims" | sudo tee -a /etc/paths.d/pyenv
	sudo chmod 0644 /etc/paths.d/pyenv

PYENV_TARGETS += pyenv-setup-shell

ifeq (${OS},Darwin)
# For GUI applications on macOS
DESKTOP_TARGETS += pyenv-darwin-path-setup
.PHONY : pyenv-deps
pyenv-deps : pyenv-deps-darwin
PYENV_TARGETS += pyenv-deps-darwin
endif
ifneq (${OS},Darwin)
pyenv-deps : pyenv-deps-${DISTRIBUTION}
PYENV_TARGETS += pyenv-deps-${DISTRIBUTION}
endif

.PHONY : app-pyenv
app-pyenv : $(PYENV_TARGETS) pyenv-install
DESKTOP_TARGETS += app-pyenv

.PHONY : test-app-pyenv
test-app-pyenv :
	[[ -x ${HOME}/.pyenv/bin/pyenv ]] || exit 1
	echo ${PATH} | grep pyenv/shims || exit 1
	echo ${PATH} | grep pyenv/bin || exit 1
	python --version | grep "${PYENV_VERSION}"
	type pip | grep .pyenv/shims/pip
	cat ${PYENV_DEFAULT_PACKAGES} | xargs -I "{}" bash -c "pip list --format=freeze | grep {}"
	@echo "Testing successful."
