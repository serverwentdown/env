#!/bin/sh

set -eu

wget \
	--output-document zsh-completions.tar.gz \
	https://github.com/zsh-users/zsh-completions/archive/refs/heads/master.tar.gz
tar -xzf zsh-completions.tar.gz \
	--strip-components=2 \
	zsh-completions-master/src
rm zsh-completions.tar.gz

wget \
	--output-document _docker \
	https://github.com/docker/cli/raw/master/contrib/completion/zsh/_docker

wget \
	--output-document _docker-compose \
	https://github.com/greymd/docker-zsh-completion/raw/master/repos/docker/compose/master/contrib/completion/zsh/_docker-compose
