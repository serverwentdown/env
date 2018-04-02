
# terminal settings
export TERM=xterm-256color

# zsh settings
export SAVEHIST=1000
export HISTFILE=~/.zsh_history
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

# pure
autoload -U promptinit; promptinit
prompt pure

# golang
export PATH="$(go env GOPATH)/bin:$PATH"

# aliases
alias vim=nvim

