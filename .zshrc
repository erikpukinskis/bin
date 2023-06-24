# ~/bin
export PATH=~/bin:$PATH
export TERM=xterm-256color

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{27}%s:%b %S/%f'
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='${NEWLINE}%F{120}%1~/%f ${vcs_info_msg_0_} %F{199}%#%f '

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Sublime
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
alias s="subl"

# NPM
export PATH=~/.npm-global/bin:$PATH

# Yarn
export PATH="$PATH:$(yarn global bin)"

# pnpm
export PNPM_HOME="/Users/erikpukinskis/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# nvm autoload
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Java
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setting PATH for Python 3.11
export PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PYTHON=/Library/Frameworks/Python.framework/Versions/3.10/bin/python3

# Secrets:
source ~/.secrets
