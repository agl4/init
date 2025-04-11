# Init

[![Lint Code Base](https://github.com/agl4/init/actions/workflows/github-super-linter.yml/badge.svg)](https://github.com/agl4/init/actions/workflows/github-super-linter.yml)

This code installs some basic tools and make some initial configuration to my
working environments.

Supports:

| Distribution/OS    -    Targets: | `make desktop` | `make server` |
|----------------------------------|----------------|---------------|
| macOS                            | *              |               |
| Ubuntu `24.04`, `24.10`, `25.04` | *              | *             |
| Fedora `42`-`43`                 | *              | *             |
| openSUSE Tumbleweed              | *              | *             |
| FreeBSD `14`                     |                | *             |
| Raspbian                         |                | *             |

## Prerequisites

Run [`bootstrap.sh`](./bootstrap.sh), which installs the dependencies.

```shell
curl -fsSL https://raw.githubusercontent.com/agl4/init/refs/heads/main/bootstrap.sh | sh
```

## Install

To clone the repository run the following:

```shell
git clone https://github.com/agl4/init
```

### Desktop environment

To configure a full environment, use:

```shell
make desktop
```

### Server environment

The server environment contains the same base package set, shell configuration and scripts, but also configures `sshd`. To install, use:

```shell
make server
```

## GitHub authentication

To authenticate git over HTTPS with GitHub use:

```shell
gh auth login -p https
```

Also setup `gh` authentication to `.gitconfig`:

```shell
gh auth setup-git
```
## Targets

|               | `make desktop` | `make server` |
|---------------|----------------|---------------|
| `make base`   | *              | *             |
| `make nodenv` | *              |               |
| `make pyenv`  | *              |               |
| `make server` |                | *             |

### `make base`

To install the base packages and setup shell use `make base`. This target is supported on all operating systems.

| Distribution/OS     | status                                                                                                                                                                                                        |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| macOS               | [![base-macos](https://github.com/agl4/init/actions/workflows/base-macos.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/base-macos.yml)                                           |
| Fedora              | [![base-fedora](https://github.com/agl4/init/actions/workflows/base-fedora.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/base-fedora.yml)                                        |
| Ubuntu              | [![base-ubuntu](https://github.com/agl4/init/actions/workflows/base-ubuntu.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/base-ubuntu.yml)                                        |
| openSUSE Tumbleweed | [![base-opensuse-tumbleweed](https://github.com/agl4/init/actions/workflows/base-opensuse-tumbleweed.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/base-opensuse-tumbleweed.yml) |
| FreeBSD             | [![base-freebsd](https://github.com/agl4/init/actions/workflows/base-freebsd.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/base-freebsd.yml)                                     |

### `make nodenv`

To install a Node.js environment using [`nodenv`](https://github.com/nodenv/nodenv), use `make nodenv`

| Distribution/OS     | status                                                                                                                                                                                                                        |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| macOS               | [![nodenv-macos](https://github.com/agl4/init/actions/workflows/apps-nodenv-macos.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-nodenv-macos.yml)                                           |
| Fedora              | [![nodenv-fedora](https://github.com/agl4/init/actions/workflows/apps-nodenv-fedora.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-nodenv-fedora.yml)                                        |
| Ubuntu              | [![nodenv-ubuntu](https://github.com/agl4/init/actions/workflows/apps-nodenv-ubuntu.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-nodenv-ubuntu.yml)                                        |
| openSUSE Tumbleweed | [![nodenv-opensuse-tumbleweed](https://github.com/agl4/init/actions/workflows/apps-nodenv-opensuse-tumbleweed.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-nodenv-opensuse-tumbleweed.yml) |

### `make pyenv`

To install a Python environment using [`pyenv`](https://github.com/pyenv/pyenv) use `make pyenv`.

| Distribution/OS     | status                                                                                                                                                                                                                     |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| macOS               | [![pyenv-macos](https://github.com/agl4/init/actions/workflows/apps-pyenv-macos.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-pyenv-macos.yml)                                           |
| Fedora              | [![pyenv-fedora](https://github.com/agl4/init/actions/workflows/apps-pyenv-fedora.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-pyenv-fedora.yml)                                        |
| Ubuntu              | [![pyenv-ubuntu](https://github.com/agl4/init/actions/workflows/apps-pyenv-ubuntu.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-pyenv-ubuntu.yml)                                        |
| openSUSE Tumbleweed | [![pyenv-opensuse-tumbleweed](https://github.com/agl4/init/actions/workflows/apps-pyenv-opensuse-tumbleweed.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-pyenv-opensuse-tumbleweed.yml) |
