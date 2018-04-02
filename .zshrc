
# zsh settings
setopt appendhistory
setopt autocd
setopt extendedglob
export TERM=xterm-256color

# golang
export PATH="$(go env GOPATH)/bin:$PATH"

# aliases
alias vim=nvim

# pure
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit; promptinit
prompt pure

