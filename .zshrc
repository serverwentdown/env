
# zsh settings
setopt appendhistory
setopt autocd
setopt extendedglob
export TERM=xterm-256color

# pure
autoload -U promptinit; promptinit
prompt pure

# golang
export PATH="$(go env GOPATH)/bin:$PATH"

# aliases
alias vim=nvim

