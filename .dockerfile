FROM alpine:latest

# create user

RUN adduser -s /bin/zsh -D ambrose

# install dotfiles

WORKDIR /home/ambrose
COPY --chown=ambrose:ambrose . .

# install tools from source

# system
RUN ./.install/core.sh
RUN ./.install/sdk.sh
RUN ./.install/sudo.sh
RUN ./.install/archival.sh
RUN ./.install/git.sh
RUN ./.install/zsh.sh
RUN ./.install/neovim.sh
# languages
RUN ./.install/python.sh
RUN ./.install/golang.sh
RUN ./.install/node.sh
#RUN ./.install/jdk.sh

# switch to user

USER ambrose

# install user programs

# shell config
RUN ./.install/pure.sh
RUN ./.install/thefuck.sh
RUN ./.install/zsh-autosuggestions.sh
# editor
RUN ./.install/plug.sh
# tools
RUN ./.install/yadm.sh
RUN ./.install/vgo.sh
RUN ./.install/packr.sh
RUN ./.install/caddy.sh
RUN ./.install/kubectl.sh
#RUN ./.install/gradlr.sh
#RUN ./.install/grunt.sh
#RUN ./.install/gulp.sh

# open login shell by default

CMD ["/bin/zsh", "-l"]
