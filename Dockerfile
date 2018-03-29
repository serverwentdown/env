FROM alpine:latest

# Install dotfiles

WORKDIR /home/ambrose

COPY . .

# Install tools from source

RUN ./.install/install.sh

# Create user

RUN adduser -s /bin/zsh -D ambrose
USER ambrose

# Open shell by default

CMD ["/bin/zsh"]
