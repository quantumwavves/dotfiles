# Prompt p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Set path for framework
export ZSH="$HOME/.oh-my-zsh"
#Plugins
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
	)

source $ZSH/oh-my-zsh.sh

# Paths
export PATH=$PATH:"$HOME/.local/bin"

# Alias
alias ls='lsd'
alias sshk='kitty +kitten ssh'
source ~/.powerlevel10k/powerlevel10k.zsh-theme

# Misc
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Setup tmux
if [ -z $TMUX ]; then; tmux; fi
