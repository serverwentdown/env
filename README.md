
# [env](https://registry.labs.0x.no/tags/env) [![Build Status](https://drone.labs.0x.no/api/badges/serverwentdown/env/status.svg)](https://drone.labs.0x.no/serverwentdown/env)

Not only dotfiles, but also a Docker environment. 

## Usage

```sh
$ docker run -it -p 8080:8080 -v $PWD:/home/ambrose/src registry.labs.0x.no/env
$ yadm clone https://github.com/serverwentdown/env.git
$ yadm decrypt
```

Or to run without yadm: 

```sh
$ docker run -it -p 8080:8080 -v $PWD:/home/ambrose/src -v $HOME/.ssh:/home/ambrose/.ssh registry.labs.0x.no/env
```

Which, is also packed as a script: 

```sh
$ curl -fLo ~/.bin/runenv https://raw.githubusercontent.com/serverwentdown/env/master/.runenv
$ chmod +x ~/.bin/runenv
$ runenv
```

## Additional features

```
./.install/jdk.sh
```
