# === PATHS E VARIÁVEIS GLOBAIS ===
if [[ $(uname -m) == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
else
    HOMEBREW_PREFIX="/usr/local"
fi

if [[ -f "$HOMEBREW_PREFIX/bin/brew" ]]; then
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

# === HISTÓRICO DO ZSH ===
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS HIST_VERIFY HIST_EXPIRE_DUPS_FIRST

# === LOCALIZAÇÃO ===
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# === EDITORES ===
export EDITOR="vim"
export VISUAL="vim"

# === PATHS ===
export GOPATH="${HOME}/.go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# === NVM (LAZY LOAD) ===
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm node npm npx
    if [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]]; then
        source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
    elif [[ -s "$NVM_DIR/nvm.sh" ]]; then
        source "$NVM_DIR/nvm.sh"
    fi
    nvm "$@"
}
node() { nvm; node "$@"; }
npm()  { nvm; npm  "$@"; }
npx()  { nvm; npx  "$@"; }

# === RBENV ===
if [[ -d "$HOME/.rbenv" ]]; then
    eval "$(rbenv init -)"
fi

# === PYENV (LAZY LOAD) ===
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT" ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    pyenv() {
        unset -f pyenv python python3 pip pip3
        eval "$(command pyenv init -)"
        pyenv "$@"
    }
    python()  { pyenv; python  "$@"; }
    python3() { pyenv; python3 "$@"; }
    pip()     { pyenv; pip     "$@"; }
    pip3()    { pyenv; pip3    "$@"; }
fi

# === JENV ===
if [[ -d "$HOME/.jenv" ]]; then
    export PATH="${HOME}/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

# === ANTIGEN E PLUGINS ===
if [[ -f "$HOMEBREW_PREFIX/share/antigen/antigen.zsh" ]]; then
    source "$HOMEBREW_PREFIX/share/antigen/antigen.zsh"
elif [[ -f "/usr/share/zsh/share/antigen.zsh" ]]; then
    source "/usr/share/zsh/share/antigen.zsh"
fi

if command -v antigen >/dev/null; then
    antigen use oh-my-zsh
    antigen bundle git
    antigen bundle kubectl
    antigen bundle golang
    antigen bundle aws
    antigen bundle terraform
    antigen bundle rust
    antigen bundle node
    antigen bundle chrissicool/zsh-256color
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions
    antigen apply
fi

# === STARSHIP E FZF ===
eval "$(starship init zsh)" 2>/dev/null || true
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# === PODMAN ===
# Auto-start podman machine if not running (for MCP servers)
if command -v podman &>/dev/null; then
    if ! podman machine inspect podman-machine-default --format '{{.State}}' 2>/dev/null | grep -q "running"; then
        podman machine start &>/dev/null &
    fi
fi

# === COMPLETIONS ===
mkdir -p "$HOME/.zsh/completions"
fpath=("$HOME/.zsh/completions" "$HOME/.docker/completions" $fpath)

if command -v helm >/dev/null && [[ ! -f "$HOME/.zsh/completions/_helm" ]]; then
    helm completion zsh > "$HOME/.zsh/completions/_helm" 2>/dev/null
fi

if command -v kubectl >/dev/null && [[ ! -f "$HOME/.zsh/completions/_kubectl" ]]; then
    kubectl completion zsh > "$HOME/.zsh/completions/_kubectl" 2>/dev/null
fi

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# === GOOGLE CLOUD SDK ===
if [[ -f "$HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc" ]]; then
    . "$HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
fi
if [[ -f "$HOMEBREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc" ]]; then
    . "$HOMEBREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
fi
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# === SDKMAN ===
[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# === ALIASES ===
alias k=kubectl

# === ENV ===
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
