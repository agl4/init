# Init

[![Lint Code Base](https://github.com/agl4/init/actions/workflows/github-super-linter.yml/badge.svg)](https://github.com/agl4/init/actions/workflows/github-super-linter.yml)

This code installs some basic tools and make some initial configuration to my
working environments.

Supports:

| Distribution/OS                  | `make` targets available |
|----------------------------------|--------------------------|
| macOS                            | `desktop`                |
| Ubuntu `24.04`, `24.10`, `25.04` | `desktop`, `server`      |
| Fedora `42`-`43`                 | `desktop`, `server`      |
| openSUSE Tumbleweed              | `desktop`, `server`      |
| FreeBSD `14`                     | `server`                 |
| Raspbian                         | `server`                 |


|               | `make desktop` | `make server` |
|---------------|----------------|---------------|
| `make base`   | *              | *             |
| `make nodenv` | *              |               |
| `make pyenv`  | *              |               |
| `make server` |                | *             |


`make base`

| Distribution/OS     | status                                                                                                                                                                                                        |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| macOS               |                                                                                                                                                                                                               |
| Fedora              | [![base-fedora](https://github.com/agl4/init/actions/workflows/base-fedora.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/base-fedora.yml)                                        |
| Ubuntu              | [![base-ubuntu](https://github.com/agl4/init/actions/workflows/base-ubuntu.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/base-ubuntu.yml)                                        |
| openSUSE Tumbleweed | [![base-opensuse-tumbleweed](https://github.com/agl4/init/actions/workflows/base-opensuse-tumbleweed.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/base-opensuse-tumbleweed.yml) |
| FreeBSD             |                                                                                                                                                                                                               |

`make nodenv`


| Distribution/OS     | status                                                                                                                                                                                                            |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| macOS               |                                                                                                                                                                                                                   |
| Fedora              | [![nodenv-fedora](https://github.com/agl4/init/actions/workflows/apps-nodenv-fedora.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-nodenv-fedora.yml)                                        |
| Ubuntu              | [![nodenv-ubuntu](https://github.com/agl4/init/actions/workflows/apps-nodenv-ubuntu.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-nodenv-ubuntu.yml)                                        |
| openSUSE Tumbleweed | [![nodenv-opensuse-tumbleweed](https://github.com/agl4/init/actions/workflows/apps-nodenv-opensuse-tumbleweed.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-nodenv-opensuse-tumbleweed.yml) |
| FreeBSD             |                                                                                                                                                                                                                   |

`make pyenv`

| Distribution/OS     | status                                                                                                                                                                                                         |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| macOS               |                                                                                                                                                                                                                |
| Fedora              | [![pyenv-fedora](https://github.com/agl4/init/actions/workflows/apps-pyenv-fedora.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-pyenv-fedora.yml)                                        |
| Ubuntu              | [![pyenv-ubuntu](https://github.com/agl4/init/actions/workflows/apps-pyenv-ubuntu.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-pyenv-ubuntu.yml)                                        |
| openSUSE Tumbleweed | [![pyenv-opensuse-tumbleweed](https://github.com/agl4/init/actions/workflows/apps-pyenv-opensuse-tumbleweed.yml/badge.svg?branch=main)](https://github.com/agl4/init/actions/workflows/apps-pyenv-opensuse-tumbleweed.yml) |
| FreeBSD             |                                                                                                                                                                                                                |

The target `make base` is supported everywhere.

Supported shells:

- `fish`
- `bashrc` (as a fall-back)

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
