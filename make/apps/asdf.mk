.PHONY : asdf asdf-upgrade asdf-setup-bashrc asdf-setup-zshrc

ASDF := ${PREFIX}/asdf
ASDF_PLUGINS := ghq nodejs python

ASDF_ARCH := arm64
ifeq ($(ARCHITECTURE),x86_64)
ASDF_ARCH := amd64
endif

ASDF_DOWNLOAD_LINK := https://github.com/asdf-vm/asdf/releases/download/${ASDF_VERSION}/asdf-${ASDF_VERSION}-$(shell echo "${OS}" | tr '[:upper:]' '[:lower:]')-${ASDF_ARCH}.tar.gz

$(ASDF) :
	@curl -sSL ${ASDF_DOWNLOAD_LINK} | gzip -cd | tar -xvf - -C ${PREFIX}

$(ASDF_PLUGINS) : $(ASDF)
	if [ ! -d "$(addprefix ${HOME}/.asdf/plugins/,$@)" ] ; then asdf plugin add $@ ; fi

${HOME}/.tool-versions : $(ASDF_PLUGINS)
	$(info Install tool-versions...)
	@install -v -m 0600 share/asdf/$(shell basename $@) "$@"
	 asdf install || true

${HOME}/.default-python-packages : ${HOME}/.tool-versions
	$(info update python packages...)
	@install -v -m 0600 share/asdf/requirements.txt "$@"
	@${HOME}/.asdf/shims/pip install --upgrade pip
	@${HOME}/.asdf/shims/pip install --upgrade -r "$@"

${HOME}/.default-npm-packages : ${HOME}/.tool-versions
	$(info Update npm packages...)
	@install -v -m 0600 share/asdf/$(shell basename $@) "$@"
	@xargs ${HOME}/.asdf/shims/npm install --global < "$$HOME/.default-npm-packages"
	@${HOME}/.asdf/shims/npm update -g npm
	@xargs ${HOME}/.asdf/shims/npm update --global < "$$HOME/.default-npm-packages"

asdf-upgrade: $(ASDF)
	@asdf plugin update --all

asdf-setup-bashrc:
	@grep '^export\ PATH.*\.local/bin' ${HOME}/.bashrc >/dev/null || echo 'export PATH=$$PATH:$$HOME/.local/bin' >> ${HOME}/.bashrc
	@grep '^export\ PATH.*\.asdf/shims' ${HOME}/.bashrc >/dev/null || echo 'export PATH=$$PATH:$$HOME/.asdf/shims' >> ${HOME}/.bashrc

asdf-setup-zshrc:
	@grep '^export\ PATH.*\.local/bin' ${HOME}/.zshrc >/dev/null || echo 'export PATH=$$PATH:$$HOME/.local/bin' >> ${HOME}/.zshrc
	@grep '^export\ PATH.*\.asdf/shims' ${HOME}/.zshrc >/dev/null || echo 'export PATH=$$PATH:$$HOME/.asdf/shims' >> ${HOME}/.zshrc

ASDF_TARGETS += ${HOME}/.tool-versions asdf-upgrade asdf-setup-bashrc asdf-setup-zshrc
ASDF_TARGETS += ${HOME}/.default-python-packages ${HOME}/.default-npm-packages

asdf: $(ASDF_TARGETS)
DESKTOP_TARGETS += asdf
