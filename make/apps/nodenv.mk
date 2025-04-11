# https://github.com/nodejs/node/blob/main/BUILDING.md#building-nodejs-on-supported-platforms
# https://github.com/nodejs/node/blob/main/tools/bootstrap/README.md
# https://github.com/nodejs/node/blob/main/BUILDING.md#option-2-automated-install-with-boxstarter

NODENV_VERSION := $(shell cat share/app-nodenv/.node-version)
NODENV_CONFIG_SRC := share/app-nodenv
NODENV_DEFAULT_PACKAGES := ${NODENV_CONFIG_SRC}/.default-npm-packages

.PHONY : nodenv-deps-darwin
nodenv-deps-darwin :
	@brew install python3

.PHONY : nodenv-deps-ubuntu
nodenv-deps-ubuntu :
	@sudo apt-get -y install python3 g++-12 gcc-12 make python3-pip

.PHONY : nodenv-deps-fedora
nodenv-deps-fedora :
	@sudo dnf install -y python3 gcc-c++ make python3-pip

.PHONY : nodenv-deps-opensuse-tumbleweed
nodenv-deps-opensuse-tumbleweed :
	@sudo zypper install -y python3 gcc-c++ make python3-pip

.PHONY : nodenv-install
nodenv-install :
	@git clone https://github.com/nodenv/nodenv.git ${HOME}/.nodenv || git -C ${HOME}/.nodenv pull
	@git clone https://github.com/nodenv/node-build.git ${HOME}/.nodenv/plugins/node-build || git -C ${HOME}/.nodenv/plugins/node-build pull
	@${HOME}/.nodenv/bin/nodenv install --skip-existing ${NODENV_VERSION}
	@${HOME}/.nodenv/bin/nodenv global ${NODENV_VERSION}
	@${HOME}/.nodenv/shims/npm update -g npm
	@xargs ${HOME}/.nodenv/shims/npm install --global < ${NODENV_DEFAULT_PACKAGES}
	@${HOME}/.nodenv/bin/nodenv rehash

$(BASH_PREFIX)/conf.d/nodenv.bash : ${NODENV_CONFIG_SRC}/nodenv.bash
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

$(FISH_PREFIX)/conf.d/nodenv.fish : ${NODENV_CONFIG_SRC}/nodenv.fish
	@install -m 0700 -d -v $(dir $@)
	@install -m 0600 -v $< $@

.PHONY : nodenv-setup-shell
nodenv-setup-shell : $(BASH_PREFIX)/conf.d/nodenv.bash $(FISH_PREFIX)/conf.d/nodenv.fish

.PHONY : nodenv-darwin-path-setup
nodenv-darwin-path-setup :
	sudo mkdir -p /etc/paths.d || true
	echo "${HOME}/.nodenv/bin" | sudo tee /etc/paths.d/nodenv
	echo "${HOME}/.nodenv/shims" | sudo tee -a /etc/paths.d/nodenv
	sudo chmod 0644 /etc/paths.d/nodenv

NODENV_TARGETS += nodenv-setup-shell

ifeq (${OS},Darwin)
# For GUI applications on macOS
DESKTOP_TARGETS += nodenv-darwin-path-setup
.PHONY : nodenv-deps
nodenv-deps : nodenv-deps-darwin
NODENV_TARGETS += nodenv-deps-darwin
endif
ifneq (${OS},Darwin)
nodenv-deps : nodenv-deps-${DISTRIBUTION}
NODENV_TARGETS += nodenv-deps-${DISTRIBUTION}
endif

.PHONY : app-nodenv
app-nodenv : $(NODENV_TARGETS) nodenv-install
DESKTOP_TARGETS += nodenv

.PHONY : test-app-nodenv
test-app-nodenv :
	node --version | grep "${NODENV_VERSION}"
	type npm | grep .nodenv/shims
	cat ${NODENV_DEFAULT_PACKAGES} | xargs -I "{}" bash -c "npm list -g | grep {}"
