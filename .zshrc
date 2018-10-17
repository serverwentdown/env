
# terminal settings
#export TERM=xterm-256color

# zsh settings
export SAVEHIST=10000
export HISTFILE=$HOME/.zsh_history
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
fpath=( $HOME/.zsh/functions $fpath )

# ls colors
eval $(dircolors -b $HOME/.dircolors)

# editor
export EDITOR=nvim

# pure
export PURE_PROMPT_SYMBOL='>'
export PURE_PROMPT_VICMD_SYMBOL='<'
autoload -U promptinit; promptinit
prompt pure

# autosuggestions
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
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

# gpg as ssh agent
test -e "$(which gpgconf)" && export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# iTerm2 integration
test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"
# hack to optionally get some oh-my-zsh back
export ZSH="$HOME/.oh-my-zsh"
test -e "$HOME/.oh-my-zsh/plugins/osx/osx.plugin.zsh" && source "$HOME/.oh-my-zsh/plugins/osx/osx.plugin.zsh"
# legacy scripts
test -e "$HOME/.bin" && export PATH="$HOME/.bin:$PATH" # TODO: move to .local/bin

# tips
function tips {
	echo "Some useful commands:"
	echo " - spotify || itunes	Chill out to 🎧"
	echo " - cdf			Jumps to the folder open in finder"
	echo " - quick-look		Opens file in quick look 👀"
	echo " - asciinema		Records a terminal session"
	echo " - http			Make HTTP requests"
	echo " - ghi			GitHub Issues"
	echo " - todo [task]		What it says on the tin 🗒"
	echo " - nope			When you give up on life 😖"
	echo " - imgcat photo		Preview photo inline"
	echo " - it2dl file		Downloads file"
	echo " - ^R			Searches history"
	echo " - ^Z			Suspend process"
	echo " - ⌘ B			In Finder, open a iTerm window"
    echo
    echo "In vim:"
	echo " - ctrl-v, shift-i, //"
	echo " - o (insert in new line) a (append) A (append at end) c (change selection)"
	echo " - w (start of word) e (end of word) 0 (start of line) $ (end of line)"
    echo " - k (up) j (down) h (left) l (right)"
    echo " - ~ (swap case) U (uppercase) u (lowercase) gUU guu gu$ gu0 gUaw"
    echo " - % (jump to matching brackets)"
    echo " - (jump to line in screen) H (top) M (middle) L (bottom)"
    echo " - (jump by screen to line) ctrl-u (half up) ctrl-d (half down)"
    echo " - (scroll screen, put current line at) z. (center) z+ (top) z- (bottom)"
    echo " - (scroll screen by one line) ctrl-y (up) ctrl-e (down)"
    echo " - mx (mark as x) \`x (return to x)"
}
