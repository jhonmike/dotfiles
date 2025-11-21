# === PATHS E VARIÁVEIS GLOBAIS ===
# Detectar arquitetura e configurar Homebrew
if [[ $(uname -m) == "arm64" ]]; then
    # Apple Silicon (M1/M2/M3)
    HOMEBREW_PREFIX="/opt/homebrew"
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
else
    # Intel
    HOMEBREW_PREFIX="/usr/local"
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# Configurar Homebrew se disponível
if [[ -f "$HOMEBREW_PREFIX/bin/brew" ]]; then
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

# === HISTÓRICO DO ZSH ===
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

# Compartilhar histórico entre todas as sessões do Zsh
setopt SHARE_HISTORY          # Compartilha histórico entre todas as sessões
setopt APPEND_HISTORY         # Adiciona ao histórico (não sobrescreve)
setopt INC_APPEND_HISTORY     # Salva cada comando imediatamente
setopt HIST_IGNORE_DUPS       # Não salva comandos duplicados consecutivos
setopt HIST_IGNORE_ALL_DUPS   # Remove duplicados mais antigos quando adicionar novo
setopt HIST_IGNORE_SPACE      # Não salva comandos que começam com espaço
setopt HIST_FIND_NO_DUPS      # Não mostra duplicados ao navegar no histórico
setopt HIST_REDUCE_BLANKS     # Remove espaços extras dos comandos
setopt HIST_VERIFY            # Mostra comando antes de executar (ao usar !!)
setopt HIST_EXPIRE_DUPS_FIRST # Remove duplicados primeiro quando HISTFILE estiver cheio

# === CONFIGURAÇÕES DE DESENVOLVIMENTO ===
export GOPATH="${HOME}/.go"
export PATH="$GOPATH/bin:${PATH}"
eval "$(rbenv init -)" 2>/dev/null || true

# === NVM SETUP ===
export NVM_DIR="$HOME/.nvm"
if [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]]; then
    source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
fi
if [[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ]]; then
    source "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
fi

# === ANTIGEN E PLUGINS ===
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    source /usr/share/zsh/share/antigen.zsh 2>/dev/null || true
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ -f "$HOMEBREW_PREFIX/share/antigen/antigen.zsh" ]]; then
        source "$HOMEBREW_PREFIX/share/antigen/antigen.zsh"
    elif [[ -f "/usr/local/share/antigen/antigen.zsh" ]]; then
        source "/usr/local/share/antigen/antigen.zsh"
    fi
fi

# Carregar bundles do Antigen se disponível
if command -v antigen >/dev/null; then
    antigen use oh-my-zsh
    
    # Oh-My-Zsh bundles
    antigen bundle git
    antigen bundle kubectl
    antigen bundle golang
    antigen bundle aws
    antigen bundle terraform
    antigen bundle pip
    antigen bundle rust
    antigen bundle node
    antigen bundle vault
    antigen bundle command-not-found
    
    # Additional bundles
    antigen bundle chrissicool/zsh-256color
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle soimort/translate-shell
    
    antigen apply
fi

# === PROMPTS E FERRAMENTAS ===
eval "$(starship init zsh)" 2>/dev/null || true
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# === PYTHON ===
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:${PATH}"
eval "$(pyenv init -)" 2>/dev/null || true

# === LOCALIZAÇÃO ===
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# === EDITORES ===
export EDITOR="vim"
export VISUAL="vim"

# === FERRAMENTAS ADICIONAIS ===
[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if command -v jenv >/dev/null; then
    export PATH="${HOME}/.jenv/bin:${PATH}"
    eval "$(jenv init -)"
fi

if command -v node >/dev/null && [[ -n "$HOMEBREW_PREFIX" ]]; then
    export NODE_PATH="${HOMEBREW_PREFIX}/lib/node_modules"
fi

# === COMPLETIONS ===
mkdir -p "$HOME/.zsh/completions"
fpath=("$HOME/.zsh/completions" $fpath)

if command -v helm >/dev/null; then
    helm completion zsh > "$HOME/.zsh/completions/_helm" 2>/dev/null
fi

fpath=($HOME/.docker/completions $fpath)

# === GOOGLE CLOUD SDK ===
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# === PROMPT E UI ===
# Kubernetes prompt (manual setup instead of kube-ps1 bundle)
if command -v kubectl >/dev/null; then
    source <(kubectl completion zsh) 2>/dev/null
fi

# === PATHS ADICIONAIS ===
command -v yarn >/dev/null && export PATH="$(yarn global bin):$PATH"
export PATH="$PATH:$HOME/.local/bin"

# === ALIASES ===
alias k=kubectl

# === INICIALIZAR COMPLETIONS ===
autoload -Uz compinit
compinit
