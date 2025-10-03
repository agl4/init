.PHONY : ubuntu-setup-repos
ubuntu-setup-repos : debian-update-repos
	@sudo apt-get install -y software-properties-common
	@sudo add-apt-repository -y universe
	@sudo add-apt-repository -y multiverse

/etc/apt/sources.list.d/neurodebian.sources.list :
	@curl -sSL http://neuro.debian.net/lists/${VERSION_CODENAME}.de-m.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
	@sudo apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com 0xA5D32F012649A5A9

BASE_TARGETS += ubuntu-setup-repos neurodebian
include make/distro/debian-based.mk
