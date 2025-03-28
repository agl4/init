# https://support.1password.com/install-linux/

# Installing the package on Ubuntu and Fedora takes care of the repository setup
# and things, but I thought it is safer a bit to manually configure the
# repositories and keys, according to the documentation.

1password-install-opensuse-tumbleweed :
	@sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
	@sudo zypper addrepo https://downloads.1password.com/linux/rpm/stable/x86_64 1password || true
	@sudo zypper install -y 1password

1password-install-ubuntu :
	@sudo apt-get update
	@sudo apt-get install -y curl
	@curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
	@echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
	@sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
	@curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
	@sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
	@curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
	@sudo apt-get update
	@sudo apt-get install -y 1password

1password-install-fedora :
# The repo_gpgcheck must be set to 0 here, the package sets it to 0 as well on
# automatic updates
	sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
	sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=0\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
	sudo dnf install -y 1password

1password-install-darwin :
	@brew install --cask 1password

1PASSWORD_TARGETS :=
ifeq (${OS},Darwin)
1PASSWORD_TARGETS += 1password-install-darwin
endif
ifneq (${OS},Darwin)
1PASSWORD_TARGETS += 1password-install-${DISTRIBUTION}
endif

app-1password: $(1PASSWORD_TARGETS)
