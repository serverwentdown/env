FROM alpine:latest

# install dotfiles

WORKDIR /home/ambrose
COPY . .

# install tools from source

# system
RUN ./.install/core.sh
RUN ./.install/git.sh
RUN ./.install/zsh.sh
RUN ./.install/neovim.sh
# languages
RUN ./.install/golang.sh
RUN ./.install/node.sh
RUN ./.install/python.sh
# setup global PATH
ENV PATH=/usr/local/go/bin:$PATH

# create user

RUN adduser -s /bin/zsh -D ambrose
USER ambrose

# install user programs

RUN ./.install/plug.sh
RUN ./.install/vgo.sh
RUN ./.install/caddy.sh
RUN ./.install/packr.sh

# open shell by default

ENTRYPOINT ["/bin/zsh"]
