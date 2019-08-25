
# terminal settings
#export TERM=xterm-256color

# zsh settings
export HISTSIZE=10000
export SAVEHIST=100000
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
# basic keybindings
bindkey -v
bindkey "^[[1~" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^R" history-incremental-search-backward

# zsh imports
fpath=( $HOME/.zsh/functions $fpath )

# ls colors
if [[ "$(uname -s)" == "Darwin" ]]; then
	#eval $(gdircolors -b $HOME/.dircolors)
	export CLICOLOR=1
else
	eval $(dircolors -b $HOME/.dircolors)
	alias ls='ls --color=auto'
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# completion menu
zstyle ':completion:*' menu select

# editor
export EDITOR=nvim

# pure
export PURE_PROMPT_SYMBOL='>'
export PURE_PROMPT_VICMD_SYMBOL='<'
autoload -U promptinit; promptinit
prompt pure

# autosuggestions
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'
export ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^e' autosuggest-execute

# syntax highlighting
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# thefuck
export PATH="$HOME/.local/bin:$PATH"
eval $(thefuck --alias nope)

# golang
if [[ "$(uname -s)" == "Darwin" ]]; then
	export GOPATH="$HOME/Documents/go"
fi
export PATH="$(go env GOPATH)/bin:$PATH"

# rust
if [[ -f $HOME/.cargo/env ]]; then
	source $HOME/.cargo/env
fi

# yarn bin
export PATH="$HOME/.yarn/bin:$PATH"

# aliases
alias vim=nvim

# gpg
export GPG_TTY="$(tty)"
# gpg ssh agent
test -e "$(which gpgconf)" && export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# minio client
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

# iTerm2 integration
test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"

# hack to optionally get some oh-my-zsh back
if [[ "$(uname -s)" == "Darwin" ]]; then

	export ZSH="$HOME/.oh-my-zsh"
	test -e "$HOME/.oh-my-zsh/plugins/osx/osx.plugin.zsh" && source "$HOME/.oh-my-zsh/plugins/osx/osx.plugin.zsh"
	# legacy scripts
	test -e "$HOME/.bin" && export PATH="$HOME/.bin:$PATH" # TODO: move to .local/bin
	# python path on macOS
	export PATH="$PATH:$HOME/Library/Python/3.7/bin"
	# flutter SDK
	export PATH="$PATH:$HOME/Documents/tools/flutter/bin"

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
		echo " - ^E			Executes suggestion or Emmet"
		echo " - ⌘ B			In Finder, open a iTerm window"
		echo
		echo "In vim:"
		echo " - ctrl-v, shift-i, [chars]"
		echo " - o (insert in new line) a (append) A (append at end) c (change selection)"
		echo " - w (start of word) e (end of word) 0 (start of line) $ (end of line)"
		echo " - k (up) j (down) h (left) l (right)"
		echo " - ~ (swap case) U (uppercase) u (lowercase) gUU guu gu$ gu0 gUaw"
		echo " - % (jump to matching brackets)"
		echo " - (jump to line in screen) H (top) M (middle) L (bottom)"
		echo " - (jump by screen to line) ctrl-u (half up) ctrl-d (half down)"
		echo " - (scroll screen, put current line at) zz (center) zt (top) zb (bottom)"
		echo " - (scroll screen by one line) ctrl-y (up) ctrl-e (down)"
		echo " - mx (mark as x) \`x (return to x)"
		echo " - f[char] (find char)"
	}

	#tips

fi

