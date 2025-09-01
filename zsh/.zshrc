# === PATHS E VARIÁVEIS GLOBAIS ===
export PATH="/opt/homebrew/bin:$PATH"

# === HISTÓRICO DO ZSH ===
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

# === CONFIGURAÇÕES DE DESENVOLVIMENTO ===
export GOPATH="${HOME}/.go"
export PATH="$GOPATH/bin:${PATH}"
eval "$(rbenv init -)"

# === NVM SETUP ===
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# === PLUGINS E TOOLS ===
# Antigen e bundles
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    source /usr/share/zsh/share/antigen.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
    source /opt/homebrew/share/antigen/antigen.zsh
fi

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Oh-My-Zsh bundles
antigen bundle git
antigen bundle kubectl
antigen bundle golang
antigen bundle aws
antigen bundle terraform
antigen bundle pip
antigen bundle rust
antigen bundle cargo
antigen bundle node
antigen bundle osx
antigen bundle vault
antigen bundle command-not-found

# Additional bundles
antigen bundle chrissicool/zsh-256color
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle softmoth/zsh-vim-mode
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle soimort/translate-shell

# Apply bundles
antigen apply

# Starship Prompt
eval "$(starship init zsh)"

# FZF (fuzzy finder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# === PYTHON ===
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# === LOCALIZAÇÃO ===
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# === EDITORES E TOOLS ===
export EDITOR="vim"
export VISUAL="vim"

# Homebrew
if command -v brew >/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  export PATH="${HOMEBREW_PREFIX}/sbin:${PATH}"
elif [[ -f "/opt/homebrew/bin/brew" && $(/usr/bin/uname -sm) == "Darwin arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="${HOMEBREW_PREFIX}/sbin:${PATH}"
fi

# SDKMAN
if [[ -f "$HOME/.sdkman/bin/sdkman-init.sh" && $(/usr/bin/uname -sm) == "Darwin arm64" ]]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# jEnv
if command -v jenv >/dev/null; then
  export PATH="${HOME}/.jenv/bin:${PATH}"
  eval "$(jenv init -)"
fi

# Node.js
if command -v node >/dev/null && [[ -n "$HOMEBREW_PREFIX" ]]; then
  export NODE_PATH="${HOMEBREW_PREFIX}/lib/node_modules"
fi

# === COMPLETIONS ===
# Setup completion directories
mkdir -p "$HOME/.zsh/completions"
fpath=("$HOME/.zsh/completions" $fpath)

# Helm completions (if installed)
if command -v helm >/dev/null; then
    helm completion zsh > "$HOME/.zsh/completions/_helm" 2>/dev/null
fi

# Docker completions (handled separately)
fpath=($HOME/.docker/completions $fpath)

# === PROMPT E UI ===
# Kubernetes prompt (manual setup instead of kube-ps1 bundle)
if command -v kubectl >/dev/null; then
    source <(kubectl completion zsh) 2>/dev/null
fi

# === PATHS ADICIONAIS ===
# Yarn global bin
export PATH="$(yarn global bin):$PATH"

# Local bin
export PATH=$PATH:$HOME/.local/bin

# === ALIASES ===
alias k=kubectl

# === INITIALIZE COMPLETIONS ===
autoload -Uz compinit
compinit
