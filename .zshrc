source ~/.antidote/antidote.zsh
source ~/.config/zsh/lackluster.zsh
if [[ -z "$PROFILE_SOURCED" ]]; then
    source ~/.profile
fi
source $HOME/.cargo/env
#Lines configured by zsh-newuser-install
HISTFILE=~/.zshHist
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mehdibenahmed/.zshrc'

autoload -Uz compinit
compinit

alias nv=nvim
alias ls=eza
alias wttr="curl wttr.in/nice"
alias ll="eza -l"
alias fm=yazi
# alias dnf=dnf5

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export COLOR_GRAY7=$'\x1b[38;2;170;170;170m'
export COLOR_GRAY8=$'\x1b[38;2;204;204;204m'
export COLOR_GRAY9=$'\x1b[38;2;221;221;221m'

# You can use these colors in your scripts...
# echo "${COLOR_BLUE}Some message${COLOR_RESET}"

#---- PROMPT ---- ##############################################
lackluster_reset_prompt(){
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      LL_BRANCH_NAME='(detached)'
     else
      LL_BRANCH_NAME="[$branch]"
    fi
  else
    LL_BRANCH_NAME=''
  fi

  git_status_result=$(git status --porcelain 2> /dev/null)
  if [[ "$git_status_result" != "" ]]; then
     # branch is dirty
     LL_BRANCH_COLOR=$COLOR_ORANGE
  else
     # branch is clean
     LL_BRANCH_COLOR=$COLOR_GRAY6
  fi

  LL_PWD=${PWD/$HOME/}
  if [[ $LL_PWD = "" ]];then
      LL_PWD="~"
  fi

  LL_PROMPT=$'\n'"| "
  return 0
}

setopt prompt_subst
autoload -U add-zsh-hook
add-zsh-hook precmd lackluster_reset_prompt
PROMPT='%{$LL_BRANCH_COLOR%}${LL_BRANCH_NAME} %{$COLOR_GRAY5%}${LL_PWD}%{$COLOR_RESET%}${LL_PROMPT}'

# UNCOMMENT THIS IF YOU USE VI MODE
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/N}/(main|viins)/ I}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load
eval "$(starship init zsh)"
# eval "$(zellij setup --generate-auto-start zsh)"

eval "$(zoxide init zsh)"

export PATH=$PATH:/home/wololo/.spicetify
