FROM alpine:latest

# Install tools from source

WORKDIR /

COPY .versions .versions
COPY .install/* .install/
RUN ./.install/install.sh

# Create user

RUN adduser -s /bin/zsh -D ambrose
USER ambrose

# Install dotfiles

WORKDIR /home/ambrose

COPY . .

