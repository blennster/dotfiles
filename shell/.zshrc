# First source user binaries
LOCAL_BIN="$HOME/.local/bin"
if [[ -d "$LOCAL_BIN" ]] ; then
	export PATH="$LOCAL_BIN:$PATH"
fi

# Shell bindings and prompt
source $HOME/.config/zsh/grml.zsh

# Highlighting
source $HOME/.config/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Suggestions
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Fzf
if [[ -x $(which fzf) ]] ; then
	# Arch
	if [[ -d "/usr/share/fzf" ]] ; then
		source /usr/share/fzf/key-bindings.zsh
		source /usr/share/fzf/completion.zsh
	# Ubuntu
	elif [[ -d "/usr/share/doc/fzf/examples" ]] ; then
		source /usr/share/doc/fzf/examples/key-bindings.zsh
		source /usr/share/doc/fzf/examples/completion.zsh
	fi
fi

# Prompt
if [[ $TERM != "dumb" ]]; then
  if [[ -x $(which starship) ]]; then
    prompt off
    eval "$(starship init zsh)"
  fi
fi

# History
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY

# Colored manpages
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

# Environment
CARGO_ENV="$HOME/.cargo/env"
if [[ -e "$CARGO_ENV" ]] ; then
  source "$CARGO_ENV"
fi

export GOPATH="$HOME/go"
if [[ -d "$GOPATH" ]] ; then
	export PATH="$GOPATH/bin:$PATH"
fi

export EDITOR=nvim
export BROWSER=firefox

# Aliases
alias lg='lazygit'

