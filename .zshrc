
# terminal settings
#export TERM=xterm-256color

# zsh settings
export SAVEHIST=10000
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

autoload -U compinit; compinit
bindkey -v
# search
bindkey '^R' history-incremental-search-backward

# zsh imports
fpath=( ~/.zsh/functions $fpath )

# editor
export EDITOR=nvim

# pure
export PURE_PROMPT_SYMBOL='>'
export PURE_PROMPT_VICMD_SYMBOL='<'
autoload -U promptinit; promptinit
prompt pure

# autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
export ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^e' autosuggest-accept

# thefuck
export PATH="$HOME/.local/bin:$PATH"
eval $(thefuck --alias nope)

# golang
export PATH="$(go env GOPATH)/bin:$PATH"

# aliases
alias vim=nvim

