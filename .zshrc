
# zsh settings
setopt append_history
setopt extended_history
setopt share_history
setopt histignorespace
setopt longlistjobs
setopt notify
setopt completeinword
setopt noshwordsplit
setopt auto_cd
setopt interactivecomments
setopt extended_glob
export TERM=xterm-256color

# pure
autoload -U promptinit; promptinit
prompt pure

# golang
export PATH="$(go env GOPATH)/bin:$PATH"

# aliases
alias vim=nvim

