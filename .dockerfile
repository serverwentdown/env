FROM alpine:3.12

# install essential

RUN apk add --no-cache --update openssl wget curl \
	&& echo hosts: dns files > /etc/nsswitch.conf

# install nix (https://github.com/NixOS/docker)

ARG NIX_VERSION=2.3.6
RUN wget https://nixos.org/releases/nix/nix-${NIX_VERSION}/nix-${NIX_VERSION}-x86_64-linux.tar.xz \
	&& tar xf nix-${NIX_VERSION}-x86_64-linux.tar.xz \
	&& addgroup -g 30000 -S nixbld \
	&& for i in $(seq 1 30); do adduser -S -D -h /var/empty -g "Nix build user $i" -u $((30000 + i)) -G nixbld nixbld$i ; done \
	&& mkdir -m 0755 /etc/nix \
	&& echo 'sandbox = false' > /etc/nix/nix.conf \
	&& mkdir -m 0755 /nix && USER=root sh nix-${NIX_VERSION}-x86_64-linux/install \
	&& ln -s /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/ \
	&& rm -r /nix-${NIX_VERSION}-x86_64-linux* \
	&& rm -rf /var/cache/apk/* \
	&& /nix/var/nix/profiles/default/bin/nix-collect-garbage --delete-old \
	&& /nix/var/nix/profiles/default/bin/nix-store --optimise \
	&& /nix/var/nix/profiles/default/bin/nix-store --verify --check-contents

ENV \
    ENV=/etc/profile \
    USER=root \
    PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    NIX_PATH=/nix/var/nix/profiles/per-user/root/channels

# install common

RUN apk add --no-cache --update \
	sudo \
	unzip zip tar gzip xz upx \
	\
	zsh \
	exa jq \
	neovim \
	\
	openssh-client \
	git \
	pass gnupg \
	\
	python3 py3-pip \
	alpine-sdk

# create user

RUN adduser -s /bin/zsh -D ambrose
RUN echo '' >> /etc/sudoers
RUN echo '## No password sudo' >> /etc/sudoers
RUN echo 'ambrose ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# install dotfiles

WORKDIR /home/ambrose
COPY --chown=ambrose:ambrose . .

# switch to user

USER ambrose

# install user programs

RUN pip3 install --no-cache-dir --user thefuck
RUN pip3 install --no-cache-dir --user httpie
# TODO: https://github.com/bootandy/dust/
# TODO: https://github.com/TheLocehiliosan/yadm/

# install additional tooling

RUN echo '@edge-testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN apk add --no-cache --update \
	kubectl@edge-testing \
	minio-client@edge-testing

# open login shell by default

CMD ["/bin/zsh", "-l"]
