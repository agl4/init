.PHONY : ubuntu-setup-repos
ubuntu-setup-repos : debian-update-repos
	@sudo apt-get install -y software-properties-common
	@sudo add-apt-repository -y universe
	@sudo add-apt-repository -y multiverse

BASE_TARGETS += ubuntu-setup-repos
include make/distro/debian-based.mk
