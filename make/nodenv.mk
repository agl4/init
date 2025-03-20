# https://github.com/nodejs/node/blob/main/BUILDING.md#building-nodejs-on-supported-platforms
# https://github.com/nodejs/node/blob/main/tools/bootstrap/README.md
# https://github.com/nodejs/node/blob/main/BUILDING.md#option-2-automated-install-with-boxstarter

NODENV_VERSION := $(shell cat share/nodenv/.node-version)

nodenv-deps-darwin :
	@brew install python3

nodenv-deps-ubuntu :
	@sudo apt-get -y install python3 g++-12 gcc-12 make python3-pip

nodenv-deps-fedora :
	@sudo dnf install -y python3 gcc-c++ make python3-pip

nodenv-deps-opensuse-tumbleweed :
	@sudo zypper install -y python3 gcc-c++ make python3-pip

nodenv-setup-bashrc :
	@grep '^export PATH.*nodenv' ${HOME}/.bashrc || echo 'export PATH="$$HOME/.nodenv/bin:$$PATH"' >> ${HOME}/.bashrc
	@grep '^export PATH.*nodenv' ${HOME}/.bash_profile || echo 'export PATH="$$HOME/.nodenv/bin:$$PATH"' >> ${HOME}/.bash_profile
	@grep 'nodenv init' ${HOME}/.bashrc || echo 'eval "$$(nodenv init - bash)"' >> ${HOME}/.bashrc

nodenv-setup-zshrc :
	@grep '^export PATH.*nodenv' ${HOME}/.zshrc || echo 'export PATH="$$HOME/.nodenv/bin:$$PATH"' >> ${HOME}/.zshrc
	@grep 'nodenv init' ${HOME}/.zshrc || echo 'eval "$$(nodenv init - zsh)"' >> ${HOME}/.zshrc

nodenv-install :
	@git clone https://github.com/nodenv/nodenv.git ${HOME}/.nodenv || git -C ${HOME}/.nodenv pull
	@git clone https://github.com/nodenv/node-build.git ${HOME}/.nodenv/plugins/node-build || git -C ${HOME}/.nodenv/plugins/node-build pull
	@${HOME}/.nodenv/bin/nodenv install --skip-existing ${NODENV_VERSION}
	@${HOME}/.nodenv/bin/nodenv global ${NODENV_VERSION}
	@${HOME}/.nodenv/shims/npm update -g npm
	@xargs ${HOME}/.nodenv/shims/npm install --global < "share/nodenv/.default-npm-packages"
	@${HOME}/.nodenv/bin/nodenv rehash

nodenv-darwin-path-setup :
	sudo mkdir -p /etc/paths.d || true
	echo "${HOME}/.nodenv/bin" | sudo tee /etc/paths.d/nodenv
	echo "${HOME}/.nodenv/shims" | sudo tee -a /etc/paths.d/nodenv
	sudo chmod 0644 /etc/paths.d/nodenv

NODENV_TARGETS += nodenv-setup-bashrc nodenv-setup-zshrc

ifeq (${OS},Darwin)
DESKTOP_TARGETS += nodenv-darwin-path-setup
nodenv-deps : nodenv-deps-darwin
NODENV_TARGETS += nodenv-deps-darwin
endif
ifneq (${OS},Darwin)
nodenv-deps : nodenv-deps-${DISTRIBUTION}
NODENV_TARGETS += nodenv-deps-${DISTRIBUTION}
endif

nodenv : $(NODENV_TARGETS) nodenv-install
DESKTOP_TARGETS += nodenv
