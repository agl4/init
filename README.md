# Init

This code installs some basic tools and make some initial configuration to my
working environments.

Supports:

| Distribution/OS         | `make` targets available    | tested |
|-------------------------|-----------------------------|--------|
| macOS                   | `base`, `desktop`           |        |
| Ubuntu `22.04`, `24.04` | `base`, `desktop`, `server` | `*`    |
| Fedora `41`-`42`        | `base`, `desktop`, `server` | `*`    |
| FreeBSD `14`            | `base`, `server`            | `*`    |
| Raspbian                | `base`, `server`            |        |

Supported shells:

- fish
- bashrc (as a fall-back)

## Prerequisites

Run `bootstrap.sh`, which installs the dependencies.

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

## Github authentication

To authenticate git over HTTPS with GitHub use:

```shell
gh auth login -p https
```

Also setup `gh` authentication to `.gitconfig`:

```shell
gh auth setup-git
```
