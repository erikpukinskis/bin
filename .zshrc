# Sublime
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
alias s="subl"

# NPM
export PATH=~/.npm-global/bin:$PATH

# ~/bin
export PATH=~/bin:$PATH

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{27}%s:%b/%S%f'
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='${NEWLINE}%F{120}%1~/%f ${vcs_info_msg_0_} %F{199}%#%f '

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Java
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
