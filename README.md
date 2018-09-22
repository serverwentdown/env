
# env [![Build Status](https://ci.makerforce.io/api/badges/ambrose/env/status.svg)](https://ci.makerforce.io/ambrose/env)

Just storing dotfiles in a repository isn't enough. This is almost all the tools I use, put into a Docker image that I can run anywhere

## Usage

```sh
docker run -it -p 8080:8080 -v $PWD:/home/ambrose/src registry.labs.0x.no/env
yadm clone https://github.com/serverwentdown/env.git
yadm decrypt
```

Or to run without yadm: 

```sh
docker run -it -p 8080:8080 -v $PWD:/home/ambrose/src -v $HOME/.ssh:/home/ambrose/.ssh registry.labs.0x.no/env
```

Which is also packed as a script: 

```sh
curl -fLo ~/.bin/runenv https://raw.githubusercontent.com/serverwentdown/env/master/.runenv
chmod +x ~/.bin/runenv
runenv
```

## Additional features

```sh
sudo ./.install/jdk.sh && sudo ./.install/gradlr.sh
```
