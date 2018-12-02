
# env [![Build Status](https://ci.makerforce.io/api/badges/ambrose/env/status.svg)](https://ci.makerforce.io/ambrose/env)

Just storing dotfiles in a repository isn't enough. This is almost all the tools I use, put into a Docker image that I can run anywhere

## Todo

- [ ] i3bar
- [ ] macOS support?

## Usage

```sh
docker run -it -p 8080:8080 -v $PWD:/home/ambrose/src registry.makerforce.io/ambrose/env
yadm clone git@github.com:serverwentdown/env.git
yadm decrypt
```

Or to run without yadm: 

```sh
docker run -it -p 8080:8080 -v $PWD:/home/ambrose/src -v $HOME/.ssh:/home/ambrose/.ssh registry.makerforce.io/ambrose/env
```

Which is also packed as a script: 

```sh
curl -fLo ~/.local/bin/runenv https://raw.githubusercontent.com/serverwentdown/env/master/.local/bin/runenv
chmod +x ~/.local/bin/runenv
runenv
```

## Additional features

```sh
sudo ./.install/jdk.sh && sudo ./.install/gradlr.sh
```
