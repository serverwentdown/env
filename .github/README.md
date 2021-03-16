
# env [![Build Status](https://ci.makerforce.io/api/badges/ambrose/env/status.svg)](https://ci.makerforce.io/ambrose/env)

Just storing dotfiles in a repository isn't enough. This is almost all the tools I use, put into a Docker image that I can run anywhere

## Screenshots

![](../.local/screenshots/iterm1.png)
![](../.local/screenshots/iterm1-light.png)
![](../.local/screenshots/iterm2.png)
![](../.local/screenshots/iterm3.png)
![](../.local/screenshots/iterm3-light.png)

## Usage

### Docker

```sh
export PATH="$HOME/.local/bin:$PATH"
curl -fLo ~/.local/bin/contain https://raw.githubusercontent.com/serverwentdown/env/master/.local/bin/contain
chmod +x ~/.local/bin/contain
contain -h
```

### macOS, Fedora, Alpine, Ubuntu, Debian

[Install yadm](https://yadm.io/docs/install), and then clone.

```sh
# Install yadm (macOS)
brew install yadm
# Install yadm (dirty method)
curl -fLo ~/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
chmod +x /usr/local/bin/yadm
# Clone
yadm clone git@github.com:serverwentdown/env.git
```

## Optional

```sh
git clone git@makerforce.io:ambrose/pass.git ~/.password-store
```
