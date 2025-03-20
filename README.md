# Desktop init scripts

This code installs some basic tools and make some initial configuration to my
desktop systems.

Supports:

| Distribution/OS     |                    | pipeline |
|---------------------|--------------------|----------|
| macOS               | `desktop`          |          |
| Ubuntu 22.04, 24.04 | `desktop`/`server` | `*`      |
| Fedora 42           | `desktop`/`server` | `*`      |
| FreeBSD             | `server`           |          |
| Raspbian            | `server`           |          |

## Prerequisites

Run `bootstrap.sh`, which installs the dependencies.

## Install

To install the environment run the following:

```shell
# Install git before this action of course
git clone https://github.com/agl4/init
cd init
bash bootstrap.sh && make desktop
```

By default this upgrades the whole system before installing anything. To skip
this step, set the variable `INSTALL_FAST` before running the install
scripts. This will also skip compiling everything from source with `asdf`.

```shell
INSTALL_FAST=1 make desktop
```

### Server environment

The server environment contains the same base package set, shell configuration and scripts, but also configures `sshd`. To install, use:

```shell
make server
```

## Github authentication

To authenticate git over HTTPS with GitHub use:

```shell
gh auth login -p https
```

Also setup `gh` authentication to `.gitconfig`:

```shell
gh auth setup-git
```
