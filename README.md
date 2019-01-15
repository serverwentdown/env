
# env [![Build Status](https://ci.makerforce.io/api/badges/ambrose/env/status.svg)](https://ci.makerforce.io/ambrose/env)

Just storing dotfiles in a repository isn't enough. This is almost all the tools I use, put into a Docker image that I can run anywhere

## Todo

- [ ] i3bar
- [ ] macOS support?

## Usage

### Docker

```sh
export PATH="$HOME/.local/bin:$PATH"
curl -fLo ~/.local/bin/runenv https://raw.githubusercontent.com/serverwentdown/env/master/.local/bin/runenv
chmod +x ~/.local/bin/runenv
runenv -h
```

### macOS

```sh
brew install \
	wget \
	xz \
	gnupg \
	git \
	zsh \
	neovim \
	python \
	go \
	node \
	\
	pass
brew cask install \
	java8 \
	docker \
	iterm2-nightly \
	bitbar \
	firefoxnightly
yadm clone git@github.com:serverwentdown/env.git
```

## Additional features

```sh
sudo ./.install/jdk.sh && sudo ./.install/gradlr.sh
sudo ./.install/desktop.sh && sudo ./.install/firefox.sh
```

## Keeping `.install` synchronised

```sh
for f in .install/*; do grep $f .dockerfile -q || echo "Missing: $f"; done
```

