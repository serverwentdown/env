#zmodload zsh/zprof

# basic settings

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=$HOME/.zsh_history
setopt append_history
setopt extended_history
setopt share_history
setopt histignorealldups
setopt histignorespace
setopt longlistjobs
setopt notify
setopt completeinword
setopt interactivecomments
setopt extended_glob
setopt transient_rprompt

# keybindings

bindkey -v
bindkey "^R" history-incremental-pattern-search-backward

# editors

alias vim=nvim
export EDITOR=nvim

# speed

slower_functions=()
load_slower() {
	for func in $slower_functions; do
		$func
	done
}
slowest_functions=()
load_slowest() {
	for func in $slowest_functions; do
		$func
	done
}
sup() {
	echo "Good morning, Ambrose!"
	load_slowest
}
prompt_run_count=0
on_second_prompt() {
	if [[ "$prompt_run_count" != 1 ]]; then
		(( prompt_run_count = prompt_run_count + 1 ))
	else
		#zmodload zsh/zprof
		load_slower
		load_slowest
		#zprof
		precmd_functions_remove=( on_second_prompt )
		precmd_functions=( ${precmd_functions:|precmd_functions_remove} )
	fi
}
if [[ "$USER" != "root" ]]; then
	precmd_functions+=( on_second_prompt )
fi

# executables

install_homebrew() {
	git clone https://github.com/Homebrew/brew "$HOME/.homebrew"
}
setup_local_homebrew() {
	export PATH="$HOME/.homebrew/bin:$PATH"
}
[[ -d "$HOME/.homebrew/bin" ]] && setup_local_homebrew

export PATH="$HOME/.local/bin:$HOME/.pwn/bin:$PATH"

setup_pulumi() {
	export PATH="$HOME/.pulumi/bin:$PATH"
}
[[ -d "$HOME/.pulumi/bin" ]] && setup_pulumi

setup_deno() {
	export PATH="$DENO_INSTALL/bin:$PATH"
}
export DENO_INSTALL="$HOME/.deno"
[[ -d "$DENO_INSTALL" ]] && setup_deno

setup_pyenv() {
	autoload -Uz compinit
	compinit
	unfunction -m pyenv python python3 pip pip3
	if ! command -v pyenv >/dev/null; then
		export PATH="$PYENV_ROOT/bin:$PATH"
		if [[ -n "$_OLD_VIRTUAL_PATH" ]]; then
			export _OLD_VIRTUAL_PATH="$PYENV_ROOT/bin:$_OLD_VIRTUAL_PATH"
		fi
	fi
	eval "$(pyenv init -)"
	[[ -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]] && eval "$(pyenv virtualenv-init -)"
	eval "$(pip completion --zsh)"
}
setup_pyenv_on_demand() {
	setup_pyenv_once() {
		if [[ ! -d "$PYENV_ROOT" ]] && ! which pip >/dev/null 2>/dev/null; then
			git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
			#git clone https://github.com/pyenv/pyenv-virtualenv.git "$PYENV_ROOT/plugins/pyenv-virtualenv"
		fi
		echo -n "loading pyenv... "
		setup_pyenv
	}
	setup_pyenv_when_python_version() {
		if [[ "$pwd_last" != "$PWD" ]]; then
			if [[ -f .python-version ]]; then
				setup_pyenv_once
				precmd_functions_remove=( setup_pyenv_when_python_version )
				precmd_functions=( ${precmd_functions:|precmd_functions_remove} )
			fi
		fi
	}
	precmd_functions+=( setup_pyenv_when_python_version )
	pyenv() { setup_pyenv_once && pyenv "$@" }
	python() { setup_pyenv_once && python "$@" }
	python3() { setup_pyenv_once && python3 "$@" }
	pip() { setup_pyenv_once && pip "$@" }
	pip3() { setup_pyenv_once && pip3 "$@" }
}
export PYENV_ROOT="$HOME/.pyenv"
if [[ -z "$VIRTUAL_ENV" ]]; then
	setup_pyenv_on_demand
fi

detect_venv() {
	directories=( .env env .venv venv )
	if [[ "$pwd_last" != "$PWD" ]]; then
		for directory in $directories; do
			if [[ -f "$directory/bin/activate" ]]; then
				echo -n "activating venv... "
				source "$directory/bin/activate"
				break
			fi
		done
	fi
}
if [[ -z "$VIRTUAL_ENV" ]]; then
	precmd_functions+=( detect_venv )
fi

setup_nvm() {
	unfunction -m nvm npm npx node
	source "$NVM_DIR/nvm.sh"
}
nvm_loaded=0
setup_nvm_on_demand() {
	setup_nvm_once() {
		if [[ "$nvm_loaded" != 1 ]]; then
			echo "-- Loading nvm --"
			setup_nvm && nvm_loaded=1
		fi
	}
	nvm() { setup_nvm_once && nvm "$@" }
	npm() { setup_nvm_once && npm "$@" }
	npx() { setup_nvm_once && npx "$@" }
	node() { setup_nvm_once && node "$@" }
}
export NVM_DIR="$HOME/.nvm"
[[ -d "$NVM_DIR" ]] && setup_nvm_on_demand
[[ -f "$HOME/.nvm-setup-now" ]] && setup_nvm

setup_bun() {
	export PATH="$BUN_INSTALL/bin:$PATH"
}
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL" ]] && setup_bun

#setup_ruby() {
#	export PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
#}
#which ruby >/dev/null 2>/dev/null && setup_ruby

setup_go() {
	export PATH="$(go env GOPATH)/bin:$PATH"
}
which go >/dev/null 2>/dev/null && setup_go

setup_g() {
	export PATH="$HOME/go/bin:$PATH" GOPATH="$HOME/go" GOROOT="$HOME/.go" # g-install: do NOT edit, see https://github.com/stefanmaric/g
}
[[ -f "$HOME/go/bin/g" ]] && setup_g

setup_rancher_desktop() {
	export PATH="$HOME/.rd/bin:$PATH"
}
[[ -d "$HOME/.rd/bin" ]] && setup_rancher_desktop

setup_android_sdk() {
	# See ~/.local/bin/install_android_sdk
	export ANDROID_SDK_ROOT="$HOME/.android/sdk"
	export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"
	if [[ -d "$HOME/.android/jdk" ]]; then
		export JAVA_HOME="$HOME/.android/jdk"
		export PATH="$JAVA_HOME/bin:$PATH"
	fi
}
[[ -d "$HOME/.android/sdk" ]] && setup_android_sdk

setup_flutter() {
	# See ~/.local/bin/install_android_sdk
	export PATH="$HOME/flutter/bin:$HOME/.pub-cache/bin:$PATH"
	if [[ -f /usr/sbin/flatpak ]]; then
		if ! which google-chrome >/dev/null 2>/dev/null; then
			flatpak_exports="/var/lib/flatpak/exports" # "$(flatpak --installations)/exports"
			export CHROME_EXECUTABLE="$flatpak_exports/bin/com.google.Chrome"
		fi
	fi
}
[[ -d "$HOME/flutter/bin" ]] && setup_flutter

setup_cargo() {
	export PATH="$HOME/.cargo/bin:$PATH"
}
[[ -d "$HOME/.cargo" ]] && setup_cargo

setup_rbenv() {
	unfunction -m rbenv ruby gem
	command -v rbenv >/dev/null || export PATH="$RBENV_ROOT/bin:$PATH"
	eval "$(rbenv init -)"
}
rbenv_loaded=0
setup_rbenv_on_demand() {
	setup_rbenv_once() {
		if [[ ! -d "$RBENV_ROOT" ]] && ! which ruby >/dev/null 2>/dev/null; then
			git clone https://github.com/rbenv/rbenv.git "$RBENV_ROOT"
		fi
		if [[ "$rbenv_loaded" != 1 ]]; then
			echo "-- Loading rbenv --"
			setup_rbenv && rbenv_loaded=1
		fi
	}
	rbenv() { setup_rbenv_once && rbenv "$@" }
	ruby() { setup_rbenv_once && ruby "$@" }
	gem() { setup_rbenv_once && gem "$@" }
}
export RBENV_ROOT="$HOME/.rbenv"
setup_rbenv_on_demand

# platform specific

case "$(uname -s)" in
	Darwin) PLATFORM=macos;;
	*) PLATFORM=linux;;
esac

setup_term_integration() {}
if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
	setup_term_integration() {
		if [[ -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
			source "$HOME/.iterm2_shell_integration.zsh"
		fi
	}
	alias icat="imgcat"
	alias ssh="TERM=xterm-256color ssh"
fi
if [[ "$TERM" == "foot" ]] && which foot >/dev/null 2>/dev/null; then
	alias icat="img2sixel"
	alias ssh="TERM=xterm-256color ssh"
fi
if [[ "$TERM" == "xterm-kitty" ]] && which kitty >/dev/null 2>/dev/null; then
	alias icat="kitty +kitten icat"
	alias ssh="kitty +kitten ssh"
fi
setup_term_integration

# term fixes

if [[ "$TERM" == "xterm-kitty" ]] || [[ "$TERM" == "xterm-iterm" ]]; then
	#alias sudo="sudo TERM=xterm-256color"
	term_color() {
		export TERM=xterm-256color
	}
fi

# completion

# Add default completions
fpath+="$HOME/.config/zsh-completions"
# Style completions
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format '%F{blue}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
setup_completion() {
	# Load completions
	autoload -Uz compinit
	compinit
	autoload -Uz bashcompinit
	bashcompinit

	# Setup fast apps
	if which mc >/dev/null 2>/dev/null; then
		complete -o nospace -C mc mc
	fi
	if which earthly >/dev/null 2>/dev/null; then
		complete -o nospace -C earthly earthly
	fi
}
slower_functions+=( setup_completion )
setup_completion_more() {
	# Depends:
	#setup_completion

	setup_completion_kubectl() {
		if which kubectl >/dev/null 2>/dev/null; then
			if ! [[ -f "$HOME/.cache/_kubectl" ]]; then
				kubectl completion zsh > "$HOME/.cache/_kubectl"
			fi
			source "$HOME/.cache/_kubectl"
		fi
	}
	setup_completion_kubectl

	setup_completion_pipenv() {
		if which pipenv >/dev/null 2>/dev/null; then
			if ! [[ -f "$HOME/.cache/pipenv/_pipenv" ]]; then
				_PIPENV_COMPLETE=zsh_source pipenv > "$HOME/.cache/pipenv/_pipenv"
			fi
			source "$HOME/.cache/pipenv/_pipenv"
		fi
	}
	setup_completion_pipenv

	setup_completion_nvm() {
		if [[ -d "$NVM_DIR" ]]; then
			[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
		fi
	}
	setup_completion_nvm

	setup_completion_docker() {
		if which docker >/dev/null 2>/dev/null; then
			eval "$(docker completion zsh)"
		fi
	}
	setup_completion_docker

	setup_completion_aws() {
		if which aws >/dev/null 2>/dev/null; then
			complete -C aws_completer aws
		fi
	}
	setup_completion_aws

	setup_completion_bun() {
		if [[ -d "$HOME/.bun" ]]; then
			[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
		fi
	}
	setup_completion_bun
}
slowest_functions+=( setup_completion_more )

# color pagination

alias lesscolor="less --RAW-CONTROL-CHARS"

# directory listings

export LS_COLORS='no=00:fi=00:di=36:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.hpp=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.cl=32:*.sh=32:*.bash=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.go=32:*.sql=32:*.csv=32:*.sv=32:*.svh=32:*.v=32:*.vh=32:*.vhd=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.PNG=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.nef=33:*.NEF=33:*.aac=33:*.au=33:*.flac=33:*.m4a=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.opus=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.MOV=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.webm=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.odt=31:*.dot=31:*.dotx=31:*.ott=31:*.xls=31:*.xlsx=31:*.ods=31:*.ots=31:*.ppt=31:*.pptx=31:*.odp=31:*.otp=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.zst=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:*.v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:*.sqlite=34:'
export CLICOLOR=1
export TIME_STYLE=iso
if which exa >/dev/null 2>/dev/null; then
	alias ls=exa
fi
alias ll="ls -l"
llp() {
	ll --color=always "$@" | lesscolor
}

# grep

if which rg >/dev/null 2>/dev/null; then
	rgp() {
		rg --line-number --heading --color=always "$@" | lesscolor
	}
else
	alias rg="grep --recursive --line-number"
	rgp() {
		rg --color=always "$@" | lesscolor
	}
fi

# theme

[[ -f "$HOME/.zshrc-theme" ]] && eval "$(cat "$HOME/.zshrc-theme")"

# prompt

setopt prompt_subst
# prompt: vcs
setup_prompt_vcs() {
	autoload -Uz vcs_info
	zstyle ':vcs_info:git:*' stagedstr $'%B'
	zstyle ':vcs_info:git:*' unstagedstr $'%B'
	#zstyle ':vcs_info:git:*' unstagedstr "$(tput smul)"
	zstyle ':vcs_info:git:*' formats $'%u%c%m %b %%b'
	zstyle ':vcs_info:git:*' actionformats $'%u%c%m %b (%a) %%b'
	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' check-for-changes true
	precmd_vcs_info() {
		vcs_info
	}
}
format_vcs_info() {
	local text
	text="$1"
	echo -n "$text"
}
slower_functions+=( setup_prompt_vcs )
# prompt: return code
format_return_code() {
	local return_code
	return_code=$1
	if [[ $return_code -gt 128 ]]; then
		return_code_=SIG$(kill -l $return_code)
	fi
	case $return_code in
		127) return_code_="not found";;
		126) return_code_="not exec";;
		1) return_code_="err";;
	esac
	echo -n " $return_code "
}
format_return_code_prev() {
	local text text_length width start
	if [[ $1 == 0 ]]; then
		return
	fi
	text="$(format_return_code $1)"
	text_length=${#text}
	width=$(tput cols)
	start=$(( $width - $text_length - 1 ))

	tput -S <<EOF
sgr0
sc
cuu1
hpa $start
setab $prompt_color_magenta
setaf $prompt_color_base02
EOF
	echo -n "$text"
	tput -S <<EOF
sgr0
rc
EOF
}
precmd_return_code() {
	last_status=$status
	if [[ -n "${command_current//[[:space:]]/}" ]]; then
		format_return_code_prev $last_status
	fi
}
# prompt: vi mode
typeset -g zle_vi_mode_=
zle-line-init zle-keymap-select() {
	local normal_mode insert_mode
	normal_mode=" N "
	insert_mode=" I "
	if [[ $prompt_compact == true ]]; then
		normal_mode=" "
		insert_mode=" "
	fi
	case "$KEYMAP" in
		vicmd) zle_vi_mode_=$'%K{'$prompt_color_blue'}'$normal_mode'%k';;
		viins|main) zle_vi_mode_=$'%K{'$prompt_color_green'}'$insert_mode'%k';;
		*) zle_vi_mode_=no;;
	esac
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
# prompt: parts
precmd_functions+=( precmd_return_code precmd_vcs_info )
setup_prompt_colors() {
	prompt_color_base03=8
	prompt_color_base02=0
	prompt_color_base01=10
	prompt_color_base00=11
	prompt_color_base0=12
	prompt_color_base1=14
	prompt_color_base2=7
	prompt_color_base3=15
	prompt_color_yellow=3
	prompt_color_orange=9
	prompt_color_red=1
	prompt_color_magenta=5
	prompt_color_violet=13
	prompt_color_blue=4
	prompt_color_cyan=6
	prompt_color_green=2
	prompt_color_always_base3=$prompt_color_base3
	if [[ "$ZED_TERM" == true ]]; then
		# TODO: Customization
		return
	fi
	if [[ $LIGHT == true ]]; then
		prompt_color_temp03=$prompt_color_base03
		prompt_color_temp02=$prompt_color_base02
		prompt_color_temp01=$prompt_color_base01
		prompt_color_temp00=$prompt_color_base00
		prompt_color_base03=$prompt_color_base3
		prompt_color_base02=$prompt_color_base2
		prompt_color_base01=$prompt_color_base1
		prompt_color_base00=$prompt_color_base0
		prompt_color_base0=$prompt_color_temp00
		prompt_color_base1=$prompt_color_temp01
		prompt_color_base2=$prompt_color_temp02
		prompt_color_base3=$prompt_color_temp03
	fi
}
prompt_folder_count=2
prompt_title_folder_count=1
setup_prompt() {
	local prompt_user_machine
	#global prompt_title_machine
	local prompt_fmt_italic prompt_fmt_reset
	#global prompt_fmt_title prompt_fmt_title_end prompt_fmt_window prompt_fmt_window_end
	local prompt_title prompt_user prompt_history prompt_error_prev prompt_vcs prompt_directory prompt_vi
	setup_prompt_colors
	prompt_user_machine=$''
	prompt_title_machine=$''
	if [[ -n "$SSH_CLIENT" ]]; then
		prompt_user_machine=$'@%m'
		prompt_title_machine=$'%m:'
	fi
	if [[ "$CONTAIN" == true ]]; then
		prompt_user_machine=$'#%m'
		prompt_title_machine=$'%m#'
	fi
	case "$TERM" in
		screen*|tmux*)
			prompt_title_machine=
			;;
	esac
	#prompt_fmt_bold=$(tput bold)
	#prompt_fmt_italic=$(tput sitm)
	#prompt_fmt_reset=$(tput sgr0)
	# For performance, use xterm escape codes
	prompt_fmt_bold=$'\E[1m'
	prompt_fmt_italic=$'\E[3m'
	prompt_fmt_reset=$'\E(b\E[m'
	case "$TERM" in
		cygwin|xterm*|putty*|rxvt*|ansi|tmux*|foot)
			prompt_fmt_title=$'\e]1;'
			prompt_fmt_title_end=$'\a'
			prompt_fmt_window=$'\e]2;'
			prompt_fmt_window_end=$'\a'
			;;
		screen*)
			prompt_fmt_title=$'\ek'
			prompt_fmt_title_end=$'\e\\'
			;;
	esac
	#prompt_title="%{$prompt_fmt_title$prompt_title_machine%$prompt_title_folder_count~$prompt_fmt_title_end$prompt_fmt_window$prompt_title_machine%$prompt_title_folder_count~$prompt_fmt_window_end%}"
	prompt_title=$'%{'"$(format_prompt_title)"$'%}'
	prompt_user=$'%{'"$prompt_fmt_italic"$'%}%F{'"$prompt_color_base02"$'}%(!.%K{'"$prompt_color_orange"$'}.%K{'"$prompt_color_blue"$'}) %n'"$prompt_user_machine"$' %k%f%{'"$prompt_fmt_reset"$'%}'
	#prompt_history=$'%{'"$prompt_fmt_reset"$'%}%F{'"$prompt_color_base03"$'} %h %f'
	#prompt_return_code=$'%K{'"$prompt_color_magenta"$'}%F{'"$prompt_color_base3"$'}%{'"$(format_return_code $?)"$'%}'
	prompt_vcs=$'%F{'$prompt_color_base02$'}%K{'$prompt_color_base1$'}$(format_vcs_info $vcs_info_msg_0_)%k%f'
	prompt_directory=$'%K{'$prompt_color_base02$'} %2~ %k'
	prompt_vi=$'%F{'"$prompt_color_base02"$'}%{'"$prompt_fmt_bold"$'%}$zle_vi_mode_%{'"$prompt_fmt_reset"$'%}%f'
	if [[ $prompt_compact == true ]]; then
		prompt_vi=$'%F{'"$prompt_color_base02"$'}$zle_vi_mode_%f'
	fi
	case "$TERM_PROGRAM" in
		vscode)
			prompt_vcs=
			;;
	esac
	prompt_trunc=$'%K{'$prompt_color_base02$'}%50<..<%k'
	RPROMPT="$prompt_history$prompt_return_code$prompt_user"
	PROMPT="$prompt_title$prompt_vi$prompt_trunc$prompt_vcs$prompt_directory "
}
format_prompt_title() {
	prompt_current_program='$command_title_fmt$command_last'
	if [[ -n "$prompt_fmt_title" ]]; then
		echo -n "$prompt_fmt_title$prompt_title_machine%$prompt_title_folder_count~$prompt_current_program$prompt_fmt_title_end"
	fi
	if [[ -n "$prompt_fmt_window" ]]; then
		echo -n "$prompt_fmt_window$prompt_title_machine%$prompt_title_folder_count~$prompt_current_program$prompt_fmt_window_end"
	fi
}
prompt_compact=true
setup_prompt

setup_command_current() {
	preexec_command_current() {
		command_current=(${(z)1})
		case $command_current[1] in
			fg)	command_current="${(z)jobtexts[${(Q)command_current[2]:-%+}]}" ;;
			%*)	command_current="${(z)jobtexts[${(Q)command_current[1]:-%+}]}" ;;
		esac
		command_current="${command_current:gs/%/%%}"
		if [[ "${#command_current}" -gt $command_current_max_length ]]; then
			command_current="${command_current[1, $(( $command_current_max_length - 1 ))]}"$'\U2026'
		fi
		if [[ -n "$command_current" ]]; then
			command_last="$command_current"
			command_title_fmt=": "
		else
			command_title_fmt="$ "
			if [[ -z "$command_last" ]]; then
				command_title_fmt=""
			fi
		fi
		print -Pn "$(format_prompt_title)"
	}
}
command_current_max_length=48
setup_command_current
preexec_functions+=( preexec_command_current )
precmd_functions+=( preexec_command_current )

# command entry plugins

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
export ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^e' autosuggest-execute

setup_assistance() {
	zsh_plugins+=( autosuggestions syntax-highlighting )
	for zsh_plugin in $zsh_plugins; do
		zsh_plugin_path="zsh-$zsh_plugin/zsh-$zsh_plugin.zsh"
		if [[ -f "/usr/local/share/$zsh_plugin_path" ]]; then
			zsh_plugin_path="/usr/local/share/$zsh_plugin_path"
		elif [[ -f "/usr/share/$zsh_plugin_path" ]]; then
			zsh_plugin_path="/usr/share/$zsh_plugin_path"
		elif [[ -f "/usr/share/zsh/plugins/$zsh_plugin_path" ]]; then
			zsh_plugin_path="/usr/share/zsh/plugins/$zsh_plugin_path"
		else
			continue
		fi
		source "$zsh_plugin_path"
	done
}
slower_functions+=( setup_assistance )
setup_nope() {
	if which thefuck >/dev/null 2>/dev/null; then
		eval $(thefuck --alias nope)
	fi
}
slowest_functions+=( setup_nope )

# pwd tracking

pwd_last=
pwd_last_update() {
	pwd_last="$PWD"
}
precmd_functions+=( pwd_last_update )

# helper scripts

function theme {
	local iterm_profile term_theme term_variation gnome_theme macos_theme
	case "$2" in
		g)
			term_variation=greyscale-
		;;
		*)
			term_variation=
		;;
	esac
	case "$1" in
		light)
			iterm_profile=Light
			term_theme=${term_variation}light
			export LIGHT=true
			echo "export LIGHT=true" > "$HOME/.zshrc-theme"
			gnome_theme=Adwaita
			gnome_color_scheme=prefer-light
			macos_theme=false
		;;
		dark)
			iterm_profile=Default
			term_theme=${term_variation}dark
			export LIGHT=false
			echo "export LIGHT=false" > "$HOME/.zshrc-theme"
			gnome_theme=Adwaita-dark
			gnome_color_scheme=prefer-dark
			macos_theme=true
		;;
	esac
	if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
		echo -e "\033]50;SetProfile=$ITERM_PROFILE\a"
	fi
	if [[ "$TERM" == "xterm-kitty" ]]; then
		kitty @ set-colors -c -a "$HOME/.config/kitty/colorscheme.$term_theme.conf"
		kitty @ env LIGHT=$LIGHT
	fi
	if [[ "$TERM" == "foot-extra" ]]; then

	fi
	if [[ -z "$SSH_CLIENT" ]]; then
		ln -sf foot.$term_theme.ini "$HOME/.config/foot/foot.ini"
		ln -sf colorscheme.$term_theme.conf "$HOME/.config/kitty/colorscheme.conf"
	fi
	setup_prompt
	if [[ -z "$SSH_CLIENT" ]]; then
		if [[ $PLATFORM == linux ]] && which gsettings >/dev/null 2>/dev/null; then
			gsettings set org.gnome.desktop.interface gtk-theme $gnome_theme
			gsettings set org.gnome.desktop.interface color-scheme $gnome_color_scheme
		fi
		if [[ $PLATFORM == macos ]]; then
			osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to $macos_theme"
		fi
	fi
}

# gnupg

if which gpgconf >/dev/null 2>/dev/null; then
	if [[ -z "$SSH_CLIENT" ]] || [[ -z "$SSH_AUTH_SOCK" ]]; then
		# use gpg agent for SSH if not connected over SSH
		export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	fi
	if ! [[ -S "$SSH_AUTH_SOCK" ]]; then
		# start gpg agent for SSH access
		gpg-connect-agent /bye >/dev/null 2>&1
	fi
	if [[ $PLATFORM == macos ]] && which pinentry-mac >/dev/null 2>/dev/null; then
		# if pinentry-mac exists, relink if not done
		# see https://github.com/Homebrew/linuxbrew-core/blob/fd3dadc66f11b7317035e76552992ef368adf7ea/Formula/gnupg.rb#L46
		pinentry_configure="/usr/local/opt/pinentry/bin/pinentry"
		pinentry_mac="/usr/local/opt/pinentry-mac/bin/pinentry-mac"
		if [[ "$(readlink $pinentry_configure)" != "$pinentry_mac" ]]; then
			ln -fs $pinentry_mac $pinentry_configure
			echo "Notice: Linked pinentry to pinentry-mac. Undo with:"
			echo "  brew unlink pinentry && brew link --overwrite pinentry"
		fi
	fi

	gpg_kill() {
		# just in case
		gpgconf --kill gpg-agent
	}
	gpg_tty() {
		# put gpg pinentry on this tty
		export GPG_TTY="$(tty)"
		echo UPDATESTARTUPTTY | gpg-connect-agent >/dev/null 2>&1
	}
fi

#zprof
