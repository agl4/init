# https://tailscale.com/download/linux

.PHONY : app-tailscale
app-tailscale :
	curl -fsSL https://tailscale.com/install.sh | sh
