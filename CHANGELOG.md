# Changelog

## [4.1.0](https://github.com/agl4/init/compare/v4.0.1...v4.1.0) (2025-10-30)


### Features

* **generate-gpg-key.sh:** New script ([ede0dae](https://github.com/agl4/init/commit/ede0daec246d7add8d296be63b240d52d280b987))
* **pass-local.sh:** New script ([ee43cb9](https://github.com/agl4/init/commit/ee43cb9cf8126942c3bd1d5f547be85ed96bb37a))
* Use pass-local in scripts ([e7d1a3c](https://github.com/agl4/init/commit/e7d1a3c76004b64a63aadfb895524fc5f7976183))

## [4.0.1](https://github.com/agl4/init/compare/v4.0.0...v4.0.1) (2025-10-18)


### Bug Fixes

* **bash:** Fix PATH variable ([46c1090](https://github.com/agl4/init/commit/46c10905b78c576e0054f50c101a90f70a862627))

## [4.0.0](https://github.com/agl4/init/compare/v3.3.1...v4.0.0) (2025-09-30)


### Features

* Create make install alias ([8eb9c35](https://github.com/agl4/init/commit/8eb9c35bd151488c261935e577008760cb398d30))
* **pass-git-credential-helper.sh:** Add pass-git-credential-helper.sh ([c104f76](https://github.com/agl4/init/commit/c104f7697aa1e068a4c2ddfd4b208885a5acd711))
* Remove pyenv from default installation ([ca83aac](https://github.com/agl4/init/commit/ca83aacc8551d48e2604c4b21165a4442c853e64))
* Removing nodenv from default installation ([5041e80](https://github.com/agl4/init/commit/5041e800c70863095a7fa24bf4b2ac18ac631e41))
* Update ssh-key related tools to use local password-store ([e6b91a0](https://github.com/agl4/init/commit/e6b91a077c1c546412bd073d34d410b0dca8b456))


### Bug Fixes

* Make sure openssh server is installed ([ce0ac10](https://github.com/agl4/init/commit/ce0ac10d73e52bda971df375c44853c5a25825ff))


### Miscellaneous Chores

* release 4.0.0 ([1ee2492](https://github.com/agl4/init/commit/1ee24929e2d97e39581241de3da8a0570d06c9b0))

## [3.3.1](https://github.com/agl4/init/compare/v3.3.0...v3.3.1) (2025-09-25)


### Bug Fixes

* Update FreeBSD package list ([1800a65](https://github.com/agl4/init/commit/1800a65d4fc610f9b76c4025e42e8afe79929a1b))

## [3.3.0](https://github.com/agl4/init/compare/v3.2.0...v3.3.0) (2025-09-14)


### Features

* Change to fish pure theme ([7522c24](https://github.com/agl4/init/commit/7522c248010ca701edb5d236ed0e8f043d512a25))
* **mmegh-user-ca:** New user certificate ([194a0b5](https://github.com/agl4/init/commit/194a0b5730c511ea230e37ed3e415f3cdd545dd5))


### Bug Fixes

* Emacs is now called emacs-app ([cf74cc7](https://github.com/agl4/init/commit/cf74cc7a59ebbb9b8687a7fe934a398090acf100))
* **tmux:** Less history to keep memory usage lower ([fa7c9f4](https://github.com/agl4/init/commit/fa7c9f48ddd2150b9aeb478f5d7a338d082f2c6c))
* **tmux:** Remove color setup ([37b6a0f](https://github.com/agl4/init/commit/37b6a0f08475816e211b355f80228f510541a213))

## [3.2.0](https://github.com/agl4/init/compare/v3.1.0...v3.2.0) (2025-07-04)


### Features

* **get-link-string.sh:** New script get-link-string.sh ([d950167](https://github.com/agl4/init/commit/d950167948bd9a400d4ce192924d35fc402effe6))


### Bug Fixes

* Add alias to make ([e94df14](https://github.com/agl4/init/commit/e94df146b6b79347a3ca49e9c37158b123b5f748))

## [3.1.0](https://github.com/agl4/init/compare/v3.0.3...v3.1.0) (2025-06-17)


### Features

* Drop MacGPG in favour of gnupg and pinentry-mac ([55c8266](https://github.com/agl4/init/commit/55c82666ee6a8f1c0d7091090ec055247bc5c620))


### Bug Fixes

* Turn of git fsmonitor ([33326bf](https://github.com/agl4/init/commit/33326bf11bf30b23c67757aa149d331f83bdb31c))

## [3.0.3](https://github.com/agl4/init/compare/v3.0.2...v3.0.3) (2025-05-05)


### Bug Fixes

* Fix tmux history config ([ce061af](https://github.com/agl4/init/commit/ce061afdf9ef67edf45b80ebe9702a7f605fa4d1))

## [3.0.2](https://github.com/agl4/init/compare/v3.0.1...v3.0.2) (2025-04-13)


### Bug Fixes

* Remove fzf from FreeBSD installation ([9072fce](https://github.com/agl4/init/commit/9072fce38a8e79e9edf49a83a20daaccd3e28138))

## [3.0.1](https://github.com/agl4/init/compare/v3.0.0...v3.0.1) (2025-04-07)


### Bug Fixes

* Fix Makefile target name ([d5a637d](https://github.com/agl4/init/commit/d5a637d616dd9ae53e979493a64a0991d60b8194))

## [3.0.0](https://github.com/agl4/init/compare/v2.1.0...v3.0.0) (2025-04-02)


### ⚠ BREAKING CHANGES

* openSUSE support
* Remove unused apps

### Features

* openSUSE support ([076b5ba](https://github.com/agl4/init/commit/076b5ba0a843811e2b29ef78edbbb72d9315c83a))
* openSUSE Tumbleweed support ([d6dc7ab](https://github.com/agl4/init/commit/d6dc7abbb6d213d25f3caa270fd77ca9af7d0f2f))
* Remove unused apps ([663254f](https://github.com/agl4/init/commit/663254faed85e1a93c16f1d00996d60d665c9079))


### Bug Fixes

* Add missing dependency awk ([7bad8ec](https://github.com/agl4/init/commit/7bad8eca57d8c879f3be82975e8643b9e99e2d9f))

## [2.1.0](https://github.com/agl4/init/compare/v2.0.1...v2.1.0) (2025-03-30)


### Features

* **git:** Use config file in .config/git ([b29e475](https://github.com/agl4/init/commit/b29e47503f01efbcbc24b94fc921149a4126ae24))


### Bug Fixes

* **git:** Update aliases ([35b0380](https://github.com/agl4/init/commit/35b0380e271f53fec22535d6b774ac580981d577))

## [2.0.1](https://github.com/agl4/init/compare/v2.0.0...v2.0.1) (2025-03-25)


### Bug Fixes

* Increase tmux history ([81437d1](https://github.com/agl4/init/commit/81437d1b2dfc9db8879ba6edfca970bb36fc67ed)), closes [#154](https://github.com/agl4/init/issues/154)

## [2.0.0](https://github.com/agl4/init/compare/v1.1.0...v2.0.0) (2025-03-25)


### ⚠ BREAKING CHANGES

* Unified shellenv
* drop zsh support
* use conf.d folders for both bash and fish
* Create a unified shell environment

### Features

* Add github backup script ([0c2c459](https://github.com/agl4/init/commit/0c2c459a0dc6eea2390bc924eca701786a9b27c2))
* Add lightroom tagger script ([a80011f](https://github.com/agl4/init/commit/a80011fb2971d475a5a548aee0db70cdab1a22db))
* Bootstrapping to a base system ([326b65a](https://github.com/agl4/init/commit/326b65a823a1bbb7b4a8cb45b57ed8e3d2ccaf59))
* Create a unified shell environment ([08ac513](https://github.com/agl4/init/commit/08ac51374011c8db35b6a483b9b62174565ebf13))
* drop zsh support ([08ac513](https://github.com/agl4/init/commit/08ac51374011c8db35b6a483b9b62174565ebf13))
* Theme switcher script for linux ([90cbebe](https://github.com/agl4/init/commit/90cbebe538a3c0ae3dce4379469363ca9f76bf15))
* Unified shellenv ([67c90d4](https://github.com/agl4/init/commit/67c90d4fe0e32d00f56e75ff697c8d742395d424))
* use conf.d folders for both bash and fish ([08ac513](https://github.com/agl4/init/commit/08ac51374011c8db35b6a483b9b62174565ebf13))


### Bug Fixes

* Add caps-lock setup as script ([c22c450](https://github.com/agl4/init/commit/c22c450acb382f26682f0cee5ab0c61d7f19fb76))
* Fix bootstrapping with gmake on FreeBSD ([7886235](https://github.com/agl4/init/commit/7886235742529ba55eaae5b2b21515d4760d92b0))
* Fix path setup on fish where no fish_add_path is available ([08ac513](https://github.com/agl4/init/commit/08ac51374011c8db35b6a483b9b62174565ebf13))
* **gh:** Add warning message after installation ([30c4c6b](https://github.com/agl4/init/commit/30c4c6be5b060775d0febccb752943d51452bd7a))
* **git:** Remove git-annex aliases ([9fc054f](https://github.com/agl4/init/commit/9fc054f09c0e286949345876e27903142f898a6e))
* **npm:** Remove unused package ([0595992](https://github.com/agl4/init/commit/05959920d3da44dd5ad0dfb74c89574344fd6f14))
* Remove emacs-related script ([36553fa](https://github.com/agl4/init/commit/36553fa8b98241326600a658e6aa63b296fb1167))
* Remove fast install support [skip ci] ([5139bcb](https://github.com/agl4/init/commit/5139bcbdda350a90c856c65c0caf785be1f91352))
* Remove host ca related setup ([16567a5](https://github.com/agl4/init/commit/16567a500c2a0cceca220708da66aab05eecf7c7))

## [1.1.0](https://github.com/agl4/init/compare/v1.0.0...v1.1.0) (2025-03-20)


### Features

* Fedora 42 support ([e4f0534](https://github.com/agl4/init/commit/e4f0534280a458aee3c64ae2346d797d23ddd9c6))


### Bug Fixes

* Add pyenv rehashing after install ([f0b1d55](https://github.com/agl4/init/commit/f0b1d553edb45fd3f644e5986f4c58870b1c5837))
* Add rehashing after npm installation ([050395d](https://github.com/agl4/init/commit/050395dd14748978e5c11d90766c916c5b222f9b))
* Setting up PATH on macOS correctly ([bcd1a74](https://github.com/agl4/init/commit/bcd1a74145b4630d3f8c98ce5dcccbc814e0b4b0))

## [1.0.0](https://github.com/agl4/init/compare/v0.25.0...v1.0.0) (2025-03-19)


### ⚠ BREAKING CHANGES

* Getting rid of ASDF-VM, use pyenv and nodenv.

### Features

* Add nodenv for nodejs ([714696b](https://github.com/agl4/init/commit/714696b683ec331996e0de67cb1f46ba77a07e8c))
* Getting rid of ASDF-VM, use pyenv and nodenv. ([dea3f6b](https://github.com/agl4/init/commit/dea3f6ba28a99d4b3ff2aef1d8c85677def97bef))
* Implement pyenv ([a494e23](https://github.com/agl4/init/commit/a494e239f63620367bafbcf04e3d059270e7a54c))


### Bug Fixes

* Add curl to bootstrap.sh ([e46be2a](https://github.com/agl4/init/commit/e46be2ab7ec40064dac4e16794bda2b0e28fc135))
* Fix 1password installation ([29ba8e5](https://github.com/agl4/init/commit/29ba8e5e4295c35f24d7f9ee381a37cdb3a6e4a6))
* Fix asdf plugin update ([a761272](https://github.com/agl4/init/commit/a761272f4c6a6719998aa1f8931d1253fb708e52))
* Fix fish syntax in homebrew fish setup ([4962905](https://github.com/agl4/init/commit/4962905c6b89aac57ad231afa8f57bd0309190aa))
* Fix gh installation ([4db6b9c](https://github.com/agl4/init/commit/4db6b9c8be516e4d0f7814eda92246d9b4387d25))
* Fix homebrew invocation on fish 4.0.0 ([97711cf](https://github.com/agl4/init/commit/97711cff382dde1271a0992d2b290447cea5567b))
* Fix installation of Clouflare WARP+ ([65c6a8f](https://github.com/agl4/init/commit/65c6a8ffdab9884c0e670eb3ac1acaefea82c3e2))
* Fix PATH related issues ([7bc4585](https://github.com/agl4/init/commit/7bc4585d89e58ab38e2e4873ad22460195650315))
* Fix resilio installation ([6611f0b](https://github.com/agl4/init/commit/6611f0bf7567583bd86ac6dbfdde1a6c5a137a47))
* Fix Resilio installation ([984e128](https://github.com/agl4/init/commit/984e128cb57668c11bc714f482a44c94af3da26b))
* Fix tailscale installation ([46d19c7](https://github.com/agl4/init/commit/46d19c7668b509eec7545300c9241f354fdb5b90))
* Set GitHub username for git ([ec0bf30](https://github.com/agl4/init/commit/ec0bf3019c837d36760a8f7477d8cbf26d9eab54))
* Simplify job dependencies in CI workflow ([77dfe75](https://github.com/agl4/init/commit/77dfe7548cd6e9ebf0759ca1f7fde0467d453ad7))
* Update job dependencies for app-warp in CI workflow [skip_ci] ([2742a05](https://github.com/agl4/init/commit/2742a059ac71d753d0bf1d7df1a5486e4f130347))

## [0.25.0](https://github.com/agl4/init/compare/v0.24.1...v0.25.0) (2025-02-17)


### Features

* Load homebrew correctly ([9a46147](https://github.com/agl4/init/commit/9a461473fab1d13243a77baf931e6cc66d99750b))


### Bug Fixes

* Add PATH to zshrc as well regarding ASDF ([3c0a065](https://github.com/agl4/init/commit/3c0a0650b3001702d4b654fdbc089d471788c134))
* Fix ASDF path in bashrc ([dc49917](https://github.com/agl4/init/commit/dc49917acf5441282c81577c1328d3e0cb7d96e5))

## [0.24.1](https://github.com/agl4/init/compare/v0.24.0...v0.24.1) (2025-02-12)


### Bug Fixes

* Fix SSH client config structure ([37ba2e0](https://github.com/agl4/init/commit/37ba2e0363284fe561c56fd7ba50207fddef6394))

## [0.24.0](https://github.com/agl4/init/compare/v0.23.1...v0.24.0) (2025-02-11)


### Features

* Add gpg support ([29e412e](https://github.com/agl4/init/commit/29e412e3321e0daf7ae1c28be80e5dd1b4434290))
* Add host CA certs ([ac010ca](https://github.com/agl4/init/commit/ac010cabaa0694e3a49e7d3538077663736dbcba))
* Fish configuration ([3c82af7](https://github.com/agl4/init/commit/3c82af7c20015aaccccd909c02b38b0a37f4f8f4))
* Git configuration ([ad14da0](https://github.com/agl4/init/commit/ad14da06ea97d5172bebca635e96815416bec556))
* Install hunspell with dicts on macOS ([c05abe6](https://github.com/agl4/init/commit/c05abe651cc254bb2530c99335a9920fa12a149d))
* Shell scripts ([59da6af](https://github.com/agl4/init/commit/59da6af50140e5037ddc124c09b54c334864a5a6))
* tmux support ([74182ae](https://github.com/agl4/init/commit/74182ae822762cdca8ff40c743c7419d522d0250))
* Upgrade to asdf go version ([39696a6](https://github.com/agl4/init/commit/39696a6b99894d69ce50093ca0653736d89bdac6))


### Bug Fixes

* Add new ASDF configuration code ([e22e68a](https://github.com/agl4/init/commit/e22e68ae2486cb81383e40da51a1d9fabcb76d00))
* Correct vi binding ([335bcd0](https://github.com/agl4/init/commit/335bcd01e81b45301fae237a12a7f8dcda171baf))
* Fix updating x86 macOS ([abec6c5](https://github.com/agl4/init/commit/abec6c53bfad8b36b963dc0b027ca95709b8de1d))
* Run gnupg and git jobs as default ([888b42a](https://github.com/agl4/init/commit/888b42a37373f6fce0e449d06e3938c70a8ad252))

## [0.23.1](https://github.com/agl4/init/compare/v0.23.0...v0.23.1) (2024-11-12)


### Bug Fixes

* **warp:** Fix WARP installation ([b296184](https://github.com/agl4/init/commit/b2961844aaeb6c7acb6ebf0c5e9a73054349c16d))

## [0.23.0](https://github.com/agl4/init/compare/v0.22.0...v0.23.0) (2024-11-04)


### Features

* Cloudflare WARP client ([6c0cfd9](https://github.com/agl4/init/commit/6c0cfd9f5240f1f4561bdad3758f21e48d7170cb))


### Bug Fixes

* Add FreeBSD bootstrapping ([e3a8f36](https://github.com/agl4/init/commit/e3a8f360e895863eaf3075fe0167f15a3ed231f1))
* Add git-annex package ([8eb77c7](https://github.com/agl4/init/commit/8eb77c7a89ec94d4b799476c5d8e4439fd2082cd))
* Add MACs to sshd config ([1edf820](https://github.com/agl4/init/commit/1edf820fc87ac8f7821b9b49fc4b9efd5d788b41))
* Add missing ripgrep package ([93ff4e7](https://github.com/agl4/init/commit/93ff4e7dfb2fc00c6db1a8c468184aa696f3beae))
* Add ssh server ([acac19e](https://github.com/agl4/init/commit/acac19e259eccc33c877382e07430b478713d571))
* Add sudo package ([78b6add](https://github.com/agl4/init/commit/78b6add06ca2cf216704007fef8dce97d1e9978d))
* Fix homebrew invocation ([21679e6](https://github.com/agl4/init/commit/21679e649da91a0ecd196c413e1ce64579dd5057))
* FreeBSD fixes ([15bc1ac](https://github.com/agl4/init/commit/15bc1ac3af8f25ee9dc385f95c7aff14c7e5fdb0))
* Harden sshd ciphers and algos ([f1f4a0f](https://github.com/agl4/init/commit/f1f4a0fd7bc097606679fbc2f77b24a5d32a2ace)), closes [#114](https://github.com/agl4/init/issues/114)
* Install git-lfs ([0dd40a0](https://github.com/agl4/init/commit/0dd40a0df66f7536ab60919aef46731922e8e62c)), closes [#112](https://github.com/agl4/init/issues/112)
* Make gh auth manual ([1e47575](https://github.com/agl4/init/commit/1e47575b9c230d1188f1d21a30e311cce51d5596))
* Remove broken autotools-language-server ([c61014d](https://github.com/agl4/init/commit/c61014ddc9512bcd09e536d0525858935e607c18))
* Setup shells correctly ([994a918](https://github.com/agl4/init/commit/994a918120e07fa69e9a81f896fa862d5b695055))
* ssh-server installation ([57ddbfa](https://github.com/agl4/init/commit/57ddbfa4dcb7ba4871b0f0468bb5b0d2c0dbfbc3)), closes [#108](https://github.com/agl4/init/issues/108)

## [0.22.0](https://github.com/agl4/init/compare/v0.21.2...v0.22.0) (2024-05-09)


### Features

* Add initial FreeBSD support ([d3bd935](https://github.com/agl4/init/commit/d3bd9351cd5f65d0b3266cbb49b563c1b1aa5ce3))
* Add initial FreeBSD support ([e264be0](https://github.com/agl4/init/commit/e264be02938dc682ae5ee7e1b8333d6bef8047fe))
* Add server targets and ssh-server configuration ([c616e14](https://github.com/agl4/init/commit/c616e1471914884bb15dd91ed91a8bae77964527))
* Add server targets and ssh-server configuration ([dfbf09d](https://github.com/agl4/init/commit/dfbf09da3a061f525b17b78344ddd13091f85fa1))
* Install hunspell ([8cd0c15](https://github.com/agl4/init/commit/8cd0c15d1bcda2f0068ca2d8383e36dd4e1d048e))


### Bug Fixes

* Add emacs package ([2f4f780](https://github.com/agl4/init/commit/2f4f780a6914a5417f0da8f0e8bb27b71ea797c9))
* Makefile syntax for Darwin OS ([ab804ca](https://github.com/agl4/init/commit/ab804ca78c70d73c6c87f98978410c91948ce5e6))
* Makefile syntax for Darwin OS ([abaa532](https://github.com/agl4/init/commit/abaa532f13b4ddb09afa47506284288657ee6b5e))

## [0.21.2](https://github.com/agl4/init/compare/v0.21.1...v0.21.2) (2024-04-25)


### Bug Fixes

* Add autotools-language-server ([1f6288c](https://github.com/agl4/init/commit/1f6288c23c560e25a86d80a2c2892a62d9391cef)), closes [#89](https://github.com/agl4/init/issues/89)

## [0.21.1](https://github.com/agl4/init-desktop/compare/v0.21.0...v0.21.1) (2024-04-01)


### Bug Fixes

* ASDF installation does not require --user ([0855ab4](https://github.com/agl4/init-desktop/commit/0855ab4e6bc90b0bf90eb0608c9e8ff752a3e964))

## [0.21.0](https://github.com/agl4/init-desktop/compare/v0.20.0...v0.21.0) (2024-02-27)


### Features

* Authorize commands in GH install script ([a4f5317](https://github.com/agl4/init-desktop/commit/a4f53178b1b13a221c6e2c92259f648f99b8b464))
* Remove oauth configuration ([40528d9](https://github.com/agl4/init-desktop/commit/40528d902f7ac51956766541bed7969212f3630b))


### Bug Fixes

* Fix 1Password automatic installation ([a886df0](https://github.com/agl4/init-desktop/commit/a886df027e44d6437ae0a46c8cd3179ffe0e1e8d))
* Fix 1password installation on Ubuntu ([feabda9](https://github.com/agl4/init-desktop/commit/feabda9feb7edd52c84266c7cd8689869099258c))
* Fix Github CLI automatic installation ([9f49ec3](https://github.com/agl4/init-desktop/commit/9f49ec3bb62b1d1636e45bc65be5622a8825d92b))
* Fix python upgrade ([86b7511](https://github.com/agl4/init-desktop/commit/86b75116359ad72ac0a7b01dc755f2d8cc98f722))
* Fix resilio-sync automatic installation and startup ([dc2d63a](https://github.com/agl4/init-desktop/commit/dc2d63ac79f92ab0d41d8026f0b9588092067fb3))
* Fix tailscale automatic installation ([d50e05f](https://github.com/agl4/init-desktop/commit/d50e05f47aad44b3bb87271eed391a68152095cb))
* Remove unused packages ([cacad2e](https://github.com/agl4/init-desktop/commit/cacad2eb901e44dc29d492a19fadd30caafab001))

## [0.20.0](https://github.com/agl4/init-desktop/compare/v0.19.0...v0.20.0) (2024-02-02)


### Features

* Add Tailscale installer ([9f9fe54](https://github.com/agl4/init-desktop/commit/9f9fe541e1430e00ec69196dfe411e8974f7f860))
* Install 1password (optional) ([0073acc](https://github.com/agl4/init-desktop/commit/0073accdeff23acdd5357e4e2a057a956af25c43))
* Install resilio-sync (optional) ([56a18b8](https://github.com/agl4/init-desktop/commit/56a18b89273e70368ab7426ef8f1e7e0721f8995))
* Optional github-cli installer ([2823d47](https://github.com/agl4/init-desktop/commit/2823d475913b459214f9e85bd357e991b8a0b466))
* Remove github trust ([cf50e5b](https://github.com/agl4/init-desktop/commit/cf50e5befcdbf4a23a8ab14d59fe4373be337834))


### Bug Fixes

* Add error checking ([a4a1de5](https://github.com/agl4/init-desktop/commit/a4a1de5ffed1e8c669b396be98f93c600c16cfcd))
* Do not stop on unsupported OS ([b5fa94e](https://github.com/agl4/init-desktop/commit/b5fa94ee9b68c8086ee0c7ef9a0fb242361e1a77))
* Remove deleted script from Makefile ([083a572](https://github.com/agl4/init-desktop/commit/083a572ce7149dda9bba823960bdcbfc35143c57))

## [0.19.0](https://github.com/agl4/init-desktop/compare/v0.18.0...v0.19.0) (2024-01-20)


### Features

* Remove genssh.sh script ([a1a95c0](https://github.com/agl4/init-desktop/commit/a1a95c03c23f29d299b13c7476b50bd1f4a1650a)), closes [#66](https://github.com/agl4/init-desktop/issues/66)
* Remove ssh intialization ([ce6eab7](https://github.com/agl4/init-desktop/commit/ce6eab71f86d26d81dc7b077fecba63ff14d0c1b)), closes [#65](https://github.com/agl4/init-desktop/issues/65)
* Support for OpenSuSE Tumbleweed ([e87ca2e](https://github.com/agl4/init-desktop/commit/e87ca2e388fcdd1ead059ecaec112f75b507ad58))
* Track asdf version ([e74e585](https://github.com/agl4/init-desktop/commit/e74e58515797a086c875169dc067f8c5bec548b8)), closes [#51](https://github.com/agl4/init-desktop/issues/51)
* Unify installers ([e7ea9a0](https://github.com/agl4/init-desktop/commit/e7ea9a03a742fd69d79c648edbd6e486ae31d1ed)), closes [#64](https://github.com/agl4/init-desktop/issues/64)


### Bug Fixes

* Add mosh ([cae81c0](https://github.com/agl4/init-desktop/commit/cae81c08c97340d203d5b344e485aba8f81f8459))
* Git config generating invalid entries ([e8fd7f2](https://github.com/agl4/init-desktop/commit/e8fd7f24d41e52f324b256b5487b31e6ffaf2ebf))
* Prefer apt-get in scripts ([509d1fc](https://github.com/agl4/init-desktop/commit/509d1fc9c910b25667c20c5616ba427ed283d404))
* Sourcing asdf correctly ([99774bf](https://github.com/agl4/init-desktop/commit/99774bf63e13555d7ee5c16cddab18ec775a2842))

## [0.18.0](https://github.com/agl4/init-desktop/compare/v0.17.0...v0.18.0) (2024-01-14)


### Features

* Git OAuth support for macOS and Fedora ([3e5a3ea](https://github.com/agl4/init-desktop/commit/3e5a3ea51e618beab1291d50f4650ca8f1c9f041))

## [0.17.0](https://github.com/agl4/init-desktop/compare/v0.16.0...v0.17.0) (2024-01-12)


### Features

* **genssh.sh:** Add hostname to generated key comment ([ce55f88](https://github.com/agl4/init-desktop/commit/ce55f886b60309c766eaf1661f4bb9fe2c1d5ae5))
* Support faster installation with INSTALL_FAST ([942b2b4](https://github.com/agl4/init-desktop/commit/942b2b4acae7857c38829a38160f698f396744df))

## [0.16.0](https://github.com/agl4/init-desktop/compare/v0.15.1...v0.16.0) (2024-01-11)


### Features

* Configure git with git config ([8f8a56a](https://github.com/agl4/init-desktop/commit/8f8a56a8a54b8f79f2b24ce0b1d9b34f66c9c039))
* Initial gitconfig ([5b08509](https://github.com/agl4/init-desktop/commit/5b08509211fc259a4a35a2d56a2fd90dcb0e2f40))
* Initialize ssh config ([aace663](https://github.com/agl4/init-desktop/commit/aace663e7acfe4f55c3dc443abf7e6a28c318bcc))


### Bug Fixes

* Assume yes to repository additions ([095e329](https://github.com/agl4/init-desktop/commit/095e3294c867268aa0f8c9509f5fde502bc40672))
* Do not interrupt scripts for input ([9528068](https://github.com/agl4/init-desktop/commit/95280683df0cdeb9caa83b436670628037712c71))
* Minor tweaks to git and ssh init scripts ([25be5c8](https://github.com/agl4/init-desktop/commit/25be5c8806b592ebaec9d49ce16b1f116e098fb0))
* Move config files to shared instead of EOF ([b130021](https://github.com/agl4/init-desktop/commit/b130021a2e97841f60b0847c74bac23c36900435))
* Rename DESKTOP_INIT_SKIP_UPGRADE to SKIP_UPGRADE ([553c2f2](https://github.com/agl4/init-desktop/commit/553c2f2277bab3e5ab2117dec4af6d39e674d860))
* Run everything on make install ([1f45581](https://github.com/agl4/init-desktop/commit/1f45581f8023c3a55bf9bc4b9677f22b3476b3a3))
* Script name ([3cdf5f5](https://github.com/agl4/init-desktop/commit/3cdf5f5aed04fb565cffb79fa26ae65b61c6d717))

## [0.15.1](https://github.com/agl4/init-desktop/compare/v0.15.0...v0.15.1) (2023-12-12)


### Bug Fixes

* Install gpg-suite and emacs ([8db34f6](https://github.com/agoloncser/desktop-init-scripts/commit/8db34f690f1d052568aebfed9bad404ce4a0b6cc)), closes [#46](https://github.com/agoloncser/desktop-init-scripts/issues/46) [#42](https://github.com/agoloncser/desktop-init-scripts/issues/42)
* Remove ansible from the default packages ([9346332](https://github.com/agl4/init-desktop/commit/93463326c2cb0c7fe0290e1372c75b065da75e40))

## [0.15.0](https://github.com/agl4/init-desktop/compare/v0.14.0...v0.15.0) (2023-12-08)


### Features

* Make default-python-packages support Renovate ([0d68d51](https://github.com/agl4/init-desktop/commit/0d68d519de38abe3ad73a78bf8f5a23a62ca1f67))
* Simplify asdf installation ([2fd45e5](https://github.com/agl4/init-desktop/commit/2fd45e5796484712a01d55383d64cbb880a7b677))


### Bug Fixes

* Support both x86_64 and arm64 macOS ([d59342e](https://github.com/agl4/init-desktop/commit/d59342e1a19d76b90be8087e30cb634420e14220)), closes [#36](https://github.com/agl4/init-desktop/issues/36)

## [0.14.0](https://github.com/agl4/init-desktop/compare/v0.13.0...v0.14.0) (2023-12-02)


### Features

* make gpg ([488f742](https://github.com/agl4/init-desktop/commit/488f7427ac2748f53adaa991da3f6fda73ce1379))

## [0.13.0](https://www.github.com/agl4/init-desktop/compare/v0.12.1...v0.13.0) (2023-11-17)


### Features

* Generalize asdf installation and support Renovate ([ae49a53](https://www.github.com/agl4/init-desktop/commit/ae49a5327c05a9a72f47ed0a22672d22be4c98af))

### [0.12.1](https://www.github.com/agl4/init-desktop/compare/v0.12.0...v0.12.1) (2023-11-02)


### Bug Fixes

* Fix asdf call ([a5cc0ce](https://www.github.com/agl4/init-desktop/commit/a5cc0ce12b8b44edcf67b33e2f993456149cd734))

## [0.12.0](https://www.github.com/agl4/init-desktop/compare/v0.11.0...v0.12.0) (2023-05-19)


### Features

* **genssh:** Remove support for adding CA name to pubkey ([a4253f8](https://www.github.com/agl4/init-desktop/commit/a4253f8a49060f7115ed934e2720680bd8c15328))

## [0.11.0](https://www.github.com/agl4/init-desktop/compare/v0.10.0...v0.11.0) (2023-05-17)


### Features

* Revert FreeBSD support ([9354958](https://www.github.com/agl4/init-desktop/commit/935495865f56730cb670d5d028b29b80dc19e32f))


### Bug Fixes

* Fix package list ([9fd73d9](https://www.github.com/agl4/init-desktop/commit/9fd73d96cc454b52011bcfe0aa2e19eb27f3b84e))
* **genssh:** Add NO_PASSPHRASE option, help and clarify variables ([3616e37](https://www.github.com/agl4/init-desktop/commit/3616e370e6c60be09d64e1c3a49ab5ecc09da0e8))
* **genssh:** Add NO_PUBKEY_IN_PASS ([36aa483](https://www.github.com/agl4/init-desktop/commit/36aa483caeb5abc55ed1d7ee3980ea32909dcf1c))
* Option to skip upgrade ([ca728f4](https://www.github.com/agl4/init-desktop/commit/ca728f43e5c6a9ab5ea35907e5ca9361b2a4333c))

## [0.10.0](https://www.github.com/agl4/init-desktop/compare/v0.9.1...v0.10.0) (2023-04-14)


### Features

* Add CA support in genkey ([7bd159a](https://www.github.com/agl4/init-desktop/commit/7bd159a3eed9098becdca9cdbcecf53617b87ba0))
* **genssh:** Add pubkey to pass, control pass location ([162b217](https://www.github.com/agl4/init-desktop/commit/162b217a73f90913bf4416959dac7cbab58635a9))
* **genssh:** Add support for directory and key customization ([4b4b924](https://www.github.com/agl4/init-desktop/commit/4b4b924086bef292314157de4060e37aad6087df))
* Makefile ([87b4aa9](https://www.github.com/agl4/init-desktop/commit/87b4aa9bedb31cf84015c160269e722b42e7cc03))
* Skip upgrade ([2eb7a40](https://www.github.com/agl4/init-desktop/commit/2eb7a404ac9fcc8e281588d98f35640d9cee0860))
* Trust github, add hostkeys ([de876ee](https://www.github.com/agl4/init-desktop/commit/de876ee062a404a3b0f280042b75f641252856d8))


### Bug Fixes

* Fix unbound variable issues ([024cdb3](https://www.github.com/agl4/init-desktop/commit/024cdb3afd449e185efdad92cf3b5e0ff72f96de))
* rename script to darwin ([32ac7bf](https://www.github.com/agl4/init-desktop/commit/32ac7bfcc98930befab8931ae710e0a2be6bdec1))
* Upgrade asdf version ([28dfa80](https://www.github.com/agl4/init-desktop/commit/28dfa80d52209c5a6482c504757bda50fce2f296))

### [0.9.1](https://www.github.com/agl4/init-desktop/compare/v0.9.0...v0.9.1) (2023-03-21)


### Bug Fixes

* Add gconf2 package to Ubuntu ([15500d2](https://www.github.com/agl4/init-desktop/commit/15500d25810d62e2e2a35a9755d6f08d4c6323cc))

## [0.9.0](https://www.github.com/agl4/init-desktop/compare/v0.8.0...v0.9.0) (2022-09-07)


### Features

* Add freebsd iocage setup script ([3bd7672](https://www.github.com/agl4/init-desktop/commit/3bd7672efee8cf5bb7cc3503c61db16fcf35600d))


### Bug Fixes

* Add cmdwatch ([824373e](https://www.github.com/agl4/init-desktop/commit/824373e70f077bc67f6d1a3d67b5905ba7b14bba))
* Add date generated to ssh pubkey comment ([235508a](https://www.github.com/agl4/init-desktop/commit/235508a5ee4ef846453fe46111a7481834296bd6))
* Add help and minor fixes ([aa5b14d](https://www.github.com/agl4/init-desktop/commit/aa5b14dd117b85c890ca3a4fef2bb47613e0bd48))
* Add smartmontools ([40cbb8d](https://www.github.com/agl4/init-desktop/commit/40cbb8dd752f96e044ab1522b2bfefbcee61c1f9))
* Automatically create key ([d615b4c](https://www.github.com/agl4/init-desktop/commit/d615b4c43a8e7b4fd1b5f8e890b41a0bc321417c))
* Do not store pubkey in pass ([bfe1cae](https://www.github.com/agl4/init-desktop/commit/bfe1cae87ec4ef30826312e838cbfb2b78f319e6))
* Fix key creation ([bc40de7](https://www.github.com/agl4/init-desktop/commit/bc40de794734e42f873ff6b381c3e62c1560fb95))
* Force generate passphrase on each key generation ([8ad71dc](https://www.github.com/agl4/init-desktop/commit/8ad71dcfa5771b2a8fe52267bb7d4859e50546a1))
* Store pubkey in pass as well ([db914bc](https://www.github.com/agl4/init-desktop/commit/db914bcc55e0e1fefbc458192a7664e16ef75cd9))

## [0.8.0](https://www.github.com/agl4/init-desktop/compare/v0.7.1...v0.8.0) (2022-07-19)


### Features

* Add asdf init scripts ([83d7078](https://www.github.com/agl4/init-desktop/commit/83d7078d02366fa5eba8bbf273c321b28c929f0e))


### Bug Fixes

* Minor script fixes ([a0d32de](https://www.github.com/agl4/init-desktop/commit/a0d32defa095ac69b30b872418579c2b401646d4))

### [0.7.1](https://www.github.com/agl4/init-desktop/compare/v0.7.0...v0.7.1) (2022-06-24)


### Bug Fixes

* Ubuntu enable repos ([edd82df](https://www.github.com/agl4/init-desktop/commit/edd82dfcc35702dc34dcebb0163099726212fbb2))

## [0.7.0](https://www.github.com/agl4/init-desktop/compare/v0.6.2...v0.7.0) (2022-05-07)


### Features

* Caps script ([a2c9472](https://www.github.com/agl4/init-desktop/commit/a2c9472d0aee10c5ff2a179cc1c0afcada5c5c78))


### Bug Fixes

* Install pipenv on macos ([027257d](https://www.github.com/agl4/init-desktop/commit/027257d6955c78d7622d9492e26cdc702959c624))
* Update scripts and install pipenv ([c57cded](https://www.github.com/agl4/init-desktop/commit/c57cdedac811316fea6e17086b3c3a47f514ec8b))

### [0.6.2](https://www.github.com/agl4/init-desktop/compare/v0.6.1...v0.6.2) (2022-04-25)


### Bug Fixes

* Update packages ([0a10a57](https://www.github.com/agl4/init-desktop/commit/0a10a5766ec23c777d046008215c31b612039152))

### [0.6.1](https://www.github.com/agl4/init-desktop/compare/v0.6.0...v0.6.1) (2022-04-24)


### Bug Fixes

* Add wl-clipboard ([3522b66](https://www.github.com/agl4/init-desktop/commit/3522b664bbb348f02fe5a7a4748fbff085fc9c53))

## [0.6.0](https://www.github.com/agl4/init-desktop/compare/v0.5.1...v0.6.0) (2022-04-05)


### Features

* Add ssh key generator script ([db7bf92](https://www.github.com/agl4/init-desktop/commit/db7bf9267a808d268dc077c8963890e09087d564))
* Install homebrew locally ([0491e31](https://www.github.com/agl4/init-desktop/commit/0491e31e6d27adbde265f05797a3cfa377092436))

### [0.5.1](https://www.github.com/agl4/init-desktop/compare/v0.5.0...v0.5.1) (2022-03-09)


### Bug Fixes

* Add fish shell on linuxes ([5843188](https://www.github.com/agl4/init-desktop/commit/5843188a30455a4d6a8c8e70877fc3dde4718975))
* Add fish shell on macOS ([ed3d207](https://www.github.com/agl4/init-desktop/commit/ed3d20747e20d8c18cb06c88d6d7050047f4abbe))

## [0.5.0](https://www.github.com/agl4/init-desktop/compare/v0.4.3...v0.5.0) (2021-11-16)


### Features

* Add pass-otp ([0b72f76](https://www.github.com/agl4/init-desktop/commit/0b72f76417e817ddf9c4961e551fdf478700bb8c))

### [0.4.3](https://www.github.com/agl4/init-desktop/compare/v0.4.2...v0.4.3) (2021-10-28)


### Bug Fixes

* Add rsync ([3557aec](https://www.github.com/agl4/init-desktop/commit/3557aec8cc9dad034e5e60942bafd7a478992af6))
* Remove FreeBSD support ([d680acd](https://www.github.com/agl4/init-desktop/commit/d680acd6ec96378c71d312c048cebbdef593dc03))
* Rename directory ([0d4629c](https://www.github.com/agl4/init-desktop/commit/0d4629c336faae62324b9c7998028028649ce4c9))

### [0.4.2](https://www.github.com/agl4/init-desktop/compare/v0.4.1...v0.4.2) (2021-10-08)


### Bug Fixes

* Add bash to Ubuntu ([750a05a](https://www.github.com/agl4/init-desktop/commit/750a05a82e23c2356991c23785a0367fa6f026bc))

### [0.4.1](https://www.github.com/agl4/init-desktop/compare/v0.4.0...v0.4.1) (2021-09-28)


### Bug Fixes

* Use `GNUPGHOME` as for finding GPG home directory. ([c07eda1](https://www.github.com/agl4/init-desktop/commit/c07eda1dbe35fa90722585b39e7aeb23f0e69840))
