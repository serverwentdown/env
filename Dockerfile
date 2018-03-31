FROM alpine:latest

# Install dotfiles

WORKDIR /home/ambrose

COPY . .

# Install tools from source

RUN ./.install/core.sh
RUN ./.install/git.sh
RUN ./.install/zsh.sh
RUN ./.install/neovim.sh
RUN ./.install/golang.sh
RUN ./.install/node.sh
RUN ./.install/python.sh

RUN ./.install/caddy.sh

# Create user

RUN adduser -s /bin/zsh -D ambrose
USER ambrose

# Install user tools

RUN ./.install/vgo.sh
RUN ./.install/packr.sh

# Open shell by default

CMD ["/bin/zsh"]
