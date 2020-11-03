
# basic settings

export HISTSIZE=10000
export SAVEHIST=100000
setopt append_history
setopt extended_history
setopt share_history
setopt histignorespace
setopt longlistjobs
setopt notify
setopt completeinword
setopt interactivecomments
setopt extended_glob

# keybindings

bindkey -v
bindkey "^R" history-incremental-pattern-search-backward

# editors

alias vim=nvim
export EDITOR=nvim

# executables

export PATH="$HOME/.local/bin:$PATH"
if [[ -f "$HOME/.deno" ]]; then
	export DENO_INSTALL="$HOME/.deno"
	export PATH="$DENO_INSTALL/bin:$PATH"
fi
if [[ -f "$HOME/.gem/ruby/2.6.0/bin" ]]; then
	export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
fi
if [[ -f "$(which go 2>/dev/null)" ]]; then
	export PATH="$(go env GOPATH)/bin:$PATH"
fi
if [[ -f "$(which cargo 2>/dev/null)" ]]; then
	export PATH="$HOME/.cargo/bin:$PATH"
fi

# completion

autoload -U compinit; compinit
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

if [[ -f "$(which mc 2>/dev/null)" ]]; then
	complete -o nospace -C mc mc
fi
if [[ -f "$(which kubectl 2>/dev/null)" ]]; then
	source <(kubectl completion zsh)
fi

# platform specific

case "$(uname -s)" in
	Darwin) PLATFORM=macos;;
	*) PLATFORM=linux;;
esac

if [[ $PLATFORM == macos ]]; then
	export PATH="$HOME/Library/Python/3.8/bin:$PATH"
fi
if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
	if [[ -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
		source "$HOME/.iterm2_shell_integration.zsh"
	fi
	alias icat="imgcat"
fi
if [[ "$TERM" == "xterm-kitty" ]]; then
	alias icat="kitty +kitten icat"
	alias ssh="kitty +kitten ssh"
fi

# directory listings

export LS_COLORS='no=00:fi=00:di=36:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.hpp=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.cl=32:*.sh=32:*.bash=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.go=32:*.sql=32:*.csv=32:*.sv=32:*.svh=32:*.v=32:*.vh=32:*.vhd=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.PNG=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.nef=33:*.NEF=33:*.aac=33:*.au=33:*.flac=33:*.m4a=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.opus=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.MOV=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.webm=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.odt=31:*.dot=31:*.dotx=31:*.ott=31:*.xls=31:*.xlsx=31:*.ods=31:*.ots=31:*.ppt=31:*.pptx=31:*.odp=31:*.otp=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.zst=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:*.v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:*.sqlite=34:'
export CLICOLOR=1
export TIME_STYLE=iso
if [[ -f "$(which exa 2>/dev/null)" ]]; then
	alias ls=exa
fi

# prompt

# prompt: vcs
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' formats $' %b %u%c'
zstyle ':vcs_info:git:*' actionformats $'%(u..%B)%(c..%B) %u%c %b (%a) '
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
format_vcs_info() {
	text="$1"
	dirty=false
	while [[ "${text[-2]}" == " " ]]; do
		dirty=true
		text="${text[0,-2]}"
	done
	if $dirty; then
		echo "%B$text%b"
	else
		echo "$text"
	fi
}
# prompt: return code
format_return_code() {
	return_code_=$1
	if [[ $1 -gt 128 ]]; then
		return_code_=SIG$(kill -l $1)
	fi
	case $1 in
		127) return_code_="not found";;
		126) return_code_="not exec";;
		1) return_code_="err";;
	esac
	echo -n $return_code_
}
format_return_code_prev() {
	if [[ $1 == 0 ]]; then
		return
	fi
	text=" $(format_return_code $1) "
	text_length=${#text}
	width=$(tput cols)
	start=$(( $width - $text_length ))

	echo -n $'\e[F\e['
	echo -n $start
	echo -n $'G\e[37m\e[41m'
	echo -n "$text"
	echo -n $'\e[0m\e[E'
}
precmd_return_code() {
	format_return_code_prev $?
}
# prompt: vi mode
typeset -g zle_vi_mode_=
zle-line-init zle-keymap-select() {
	case "$KEYMAP" in
		vicmd) zle_vi_mode_=$'%K{9} N %k';;
		viins|main) zle_vi_mode_=$'%K{2} I %k';;
		*) zle_vi_mode_=no;;
	esac
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
# prompt: parts
precmd_functions+=( precmd_return_code precmd_vcs_info )
PROMPT_USER_MACHINE=$''
if [[ ! -z "$SSH_CLIENT" ]]; then
	PROMPT_USER_MACHINE=$'@%m'
fi
PROMPT_USER=$'%F{15}%{\e[3m%}%(!.%K{9}.%K{4}) %n'"$PROMPT_USER_MACHINE"$' %k%{\e[0m%}%f'
PROMPT_HISTORY=$'%F{10}%{\e[3m%} %h %{\e[0m%}%f'
PROMPT_ERROR=$'%F{15}%{\e[3m%}%(?.%K{2}.%K{1} $(format_return_code $?) )%k%{\e[0m%}%f'
PROMPT_ERROR_PREV=$'$(format_return_code_prev $?)'
PROMPT_VCS=$'%K{8}$(format_vcs_info $vcs_info_msg_0_)%k'
PROMPT_DIRECTORY=$'%K{black} %2~ %k'
PROMPT_VI=$'%F{15}%{\e[3m%}$zle_vi_mode_%{\e[0m%}%f'
RPROMPT="$PROMPT_HISTORY$PROMPT_USER"
PROMPT="$PROMPT_VI$PROMPT_VCS$PROMPT_DIRECTORY "

# command entry plugins

AUTOSUGGESTIONS="/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -f "$AUTOSUGGESTIONS" ]]; then
	export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
	export ZSH_AUTOSUGGEST_USE_ASYNC=true
	bindkey '^e' autosuggest-execute
	source "$AUTOSUGGESTIONS"
fi
SYNTAX_HIGHLIGHTING="/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "$SYNTAX_HIGHLIGHTING" ]]; then
	source "$SYNTAX_HIGHLIGHTING"
fi
if [[ -f "$(which thefuck 2>/dev/null)" ]]; then
	eval $(thefuck --alias nope)
fi

# helper scripts

function gpg_start {
	# gpg tty fix for macOS pinentry. also ensures agent is started
	export GPG_TTY="$(tty)"
	echo UPDATESTARTUPTTY | gpg-connect-agent 2>&1 >/dev/null
	# gpg ssh agent
	test -e "$(which gpgconf 2>/dev/null)" && export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
}
