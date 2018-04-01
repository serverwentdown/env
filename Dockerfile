FROM alpine:latest

# Install dotfiles

WORKDIR /home/ambrose
COPY . .

# Install tools from source

# System
RUN ./.install/core.sh
RUN ./.install/git.sh
RUN ./.install/zsh.sh
RUN ./.install/neovim.sh
# Languages
RUN ./.install/golang.sh
RUN ./.install/node.sh
RUN ./.install/python.sh
# Setup global PATH
ENV PATH=/usr/local/go/bin:$PATH

# Create user

RUN adduser -s /bin/zsh -D ambrose
USER ambrose

# Install user programs
RUN ./.install/vgo.sh
RUN ./.install/caddy.sh
RUN ./.install/packr.sh

# Open shell by default

CMD ["/bin/zsh"]
