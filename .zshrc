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
bindkey "^R" history-incremental-pattern-search-backward

# zsh imports
fpath=( $HOME/.config/zsh/functions $fpath )

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

# documents
if [[ "$(uname -s)" == "Darwin" ]]; then
	export DOC="$HOME/Documents"
else
	export DOC="$HOME"
fi

# editor
export EDITOR=nvim

# pure
export PURE_PROMPT_SYMBOL="%1{❯%}"
export PURE_PROMPT_VICMD_SYMBOL="%1{❮%}"
zstyle :prompt:pure:git:dirty color 242
# Fixes it's treatment as a double width character, see https://github.com/geometry-zsh/geometry/commit/dbd28b23293b0862055deda8e59db57ebd6d6606#diff-37d2e8a43274d6fbaf5b762a55f5138cR211
autoload -U promptinit; promptinit
prompt pure

# autosuggestions
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
export ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^e' autosuggest-execute

# syntax highlighting
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# thefuck
export PATH="$HOME/.local/bin:$PATH"
eval $(thefuck --alias nope)

# golang
if [[ -f "$(which kubectl)" ]]; then
	export PATH="$(go env GOPATH)/bin:$PATH"
fi

# rust
if [[ -f "$HOME/.cargo/env" ]]; then
	source "$HOME/.cargo/env"
fi

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# yarn bin
export PATH="$HOME/.yarn/bin:$PATH"

# minio client
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

# kubectl
if [[ -f "$(which kubectl)" ]]; then
	source <(kubectl completion zsh)
fi

# python path
if [[ "$(uname -s)" == "Darwin" ]]; then
	export PATH="$PATH:$HOME/Library/Python/3.7/bin"
	export PATH="$PATH:$HOME/Library/Python/2.7/bin"
fi
# android sdk
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools"
# flutter sdk
export PATH="$PATH:$HOME/flutter/bin"

# aliases
alias vim=nvim
alias icat="kitty +kitten icat"

# gpg help
function gpg_start {
	# gpg
	export GPG_TTY="$(tty)"
	# gpg ssh agent
	test -e "$(which gpgconf)" && export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	# gpg ssh fix pinentry
	echo "UPDATESTARTUPTTY" | gpg-connect-agent > /dev/null 2>&1
}

# iTerm2 integration
if [[ -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
	source "$HOME/.iterm2_shell_integration.zsh"
fi

# hack to optionally get some oh-my-zsh back
if [[ "$(uname -s)" == "Darwin" ]]; then

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
		echo " - cc (intent line) = (indent selection)"
		echo " - (insert mode) ctrl-y (indent) ctrl-d (unindent)"
		echo " - (jump to line in screen) H (top) M (middle) L (bottom)"
		echo " - (jump by screen to line) ctrl-u (half up) ctrl-d (half down)"
		echo " - (scroll screen, put current line at) zz (center) zt (top) zb (bottom)"
		echo " - (scroll screen by one line) ctrl-y (up) ctrl-e (down)"
		echo " - mx (mark as x) \`x (return to x)"
		echo " - f[char] (find char)"
	}

fi

