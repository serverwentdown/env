FROM alpine:latest

# create user

RUN adduser -s /bin/zsh -D ambrose

# install dotfiles

WORKDIR /home/ambrose
COPY --chown=ambrose:ambrose . .

# install tools from source

# system
RUN ./.install/core.sh
RUN ./.install/sudo.sh
RUN ./.install/archival.sh
RUN ./.install/git.sh
RUN ./.install/zsh.sh
RUN ./.install/neovim.sh
# shell config, env manager
RUN ./.install/zsh-pure.sh
RUN ./.install/thefuck.sh
RUN ./.install/yadm.sh
# languages
RUN ./.install/golang.sh
RUN ./.install/node.sh
RUN ./.install/python.sh
#RUN ./.install/jdk.sh
#RUN ./.install/gradlr.sh
# tools
RUN ./.install/kubectl.sh

# switch to user

USER ambrose

# install user programs

# shell, editor
RUN ./.install/plug.sh
# tools
RUN ./.install/vgo.sh
RUN ./.install/packr.sh
RUN ./.install/caddy.sh

# open login shell by default

CMD ["/bin/zsh", "-l"]
