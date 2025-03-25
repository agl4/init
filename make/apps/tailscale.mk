# https://tailscale.com/download/linux

.PHONY : app-tailscale
app-tailscale :
	curl -fsSL https://tailscale.com/install.sh | sh

app-tailscale-test :
	@[[ -x /usr/bin/tailscale ]] || [[ -d /Applications/Tailscale.app ]] || exit 1
