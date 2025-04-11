.PHONY : gh-install-opensuse-tumbleweed
gh-install-opensuse-tumbleweed :
	@sudo zypper addrepo https://cli.github.com/packages/rpm/gh-cli.repo
	@sudo zypper --gpg-auto-import-keys refresh
	@sudo zypper install -y gh

.PHONY : gh-install-ubuntu
gh-install-ubuntu :
	@sudo apt-get update
	@sudo apt-get install curl -y
	@curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of="/usr/share/keyrings/githubcli-archive-keyring.gpg"
	@sudo chmod go+r "/usr/share/keyrings/githubcli-archive-keyring.gpg"
	@echo "deb [arch=${ARCHITECTURE} signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
	@sudo apt-get update
	@sudo apt-get install gh -y

.PHONY : gh-install-fedora
gh-install-fedora :
	sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
	sudo dnf install -y gh

.PHONY : gh-install-darwin
gh-install-darwin :
	@brew install gh

.PHONY : gh-login
gh-login :
	@gh auth login
	@gh auth setup-git

.PHONY : gh-login-warning
gh-login-warning :
	@echo "WARNING: GitHub authentication is not done automatically, run 'make gh-login'"

GH_TARGETS :=
ifeq (${OS},Darwin)
GH_TARGETS += gh-install-darwin
endif
ifneq (${OS},Darwin)
GH_TARGETS += gh-install-${DISTRIBUTION}
endif

.PHONY : app-gh
app-gh : $(GH_TARGETS) gh-login-warning

.PHONY : test-app-gh
test-app-gh :
	[[ -x /usr/bin/gh ]] || [[ -x /opt/homebrew/bin/gh ]] || exit 1
	gh --version
	@echo "Testing successful."
