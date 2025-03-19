# https://pkg.cloudflareclient.com/

.PHONY : warp-install-ubuntu
warp-install-ubuntu :
	@curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
	@echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
	@sudo apt-get update && sudo apt-get install -y cloudflare-warp


.PHONY : warp-install-fedora
warp-install-fedora :
	@sudo dnf config-manager --add-repo https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo
	@sudo dnf install -y cloudflare-warp

# https://www.reddit.com/r/Fedora/comments/vj5x6l/comment/kakjrpu/
	@echo '[Resolve]' > /etc/systemd/resolved.conf.d/cloudflare-warp.conf
	@echo 'ResolveUnicastSingleLabel=yes' >> /etc/systemd/resolved.conf.d/cloudflare-warp.conf
	@sudo systemctl restart systemd-resolved.service

.PHONY : warp-install-darwin
warp-install-darwin :
	@brew install --cask cloudflare-warp

.PHONY : warp-configure-linux
warp-configure-linux :
	@sudo systemctl enable --now cloudflare-warp

WARP_TARGETS :=
ifeq (${OS},Darwin)
WARP_TARGETS += warp-install-darwin
endif
ifneq (${OS},Darwin)
WARP_TARGETS += warp-install-${DISTRIBUTION}
ifndef INSIDE_DOCKER
WARP_TARGETS += warp-configure-linux
endif
endif

.PHONY : app-warp
app-warp: $(WARP_TARGETS)
