FROM alpine:latest

# Install dotfiles

WORKDIR /home/ambrose

COPY . .

# Install tools from source

RUN source ./.version

RUN ./.install/zsh.sh
RUN ./.install/neovim.sh
RUN ./.install/golang.sh
RUN ./.install/node.sh
RUN ./.install/python.sh

# Create user

RUN adduser -s /bin/zsh -D ambrose
USER ambrose

# Install user tools

RUN ./.install/vgo.sh

# Open shell by default

CMD ["/bin/zsh"]
