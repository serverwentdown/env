FROM alpine:latest

# create user

RUN adduser -s /bin/zsh -D ambrose

# install dotfiles

WORKDIR /home/ambrose
COPY --chown=ambrose:ambrose . .

# install tools

# repositories
RUN ./.install/repositories.sh
# system
RUN ./.install/core.sh
RUN ./.install/sdk.sh
RUN ./.install/sudo.sh
RUN ./.install/archival.sh
RUN ./.install/git.sh
RUN ./.install/zsh.sh
RUN ./.install/neovim-source.sh
# languages
RUN ./.install/python.sh
RUN ./.install/golang-source.sh
RUN ./.install/node-source.sh
#RUN ./.install/jdk.sh

# switch to user

USER ambrose

# install user programs

# shell config
RUN ./.install/dircolors.sh
RUN ./.install/pure.sh
RUN ./.install/thefuck.sh
RUN ./.install/zsh-autosuggestions.sh
RUN ./.install/zsh-syntax-highlighting.sh
# editor
RUN ./.install/plug.sh
# tools
RUN ./.install/yadm.sh
RUN ./.install/packr.sh
RUN ./.install/caddy.sh
RUN ./.install/kubectl.sh
RUN ./.install/minio-client.sh
RUN ./.install/yarn.sh
#RUN ./.install/gradlr.sh

# open login shell by default

CMD ["/bin/zsh", "-l"]
