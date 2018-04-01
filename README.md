
# [env](https://registry.labs.0x.no/tags/env) [![Build Status](https://drone.labs.0x.no/api/badges/serverwentdown/env/status.svg)](https://drone.labs.0x.no/serverwentdown/env)

Not only dotfiles, but also a Docker environment. 

## Usage

```
$ docker run -it -p 8080:8080 -v $PWD:/home/ambrose/src registry.labs.0x.no/env
$ yadm clone https://github.com/serverwentdown/env.git
$ yadm decrypt
```

Or to run without yadm: 

```
$ docker run -it -p 8080:8080 -v $PWD:/home/ambrose/src -v $HOME/.ssh:/home/ambrose/.ssh registry.labs.0x.no/env
```
