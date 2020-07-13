source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle kube-ps1
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# vim mode
antigen bundle softmoth/zsh-vim-mode

# autosuggestions
antigen bundle zsh-users/zsh-autosuggestions

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Translate plug.
antigen bundle soimort/translate-shell

# Load the theme.
antigen theme dracula/zsh dracula

# Tell antigen that you're done.
antigen apply

# User configuration
export PROMPT=$PROMPT"\$(kube_ps1) "

export VISUAL="vim"
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:$HOME/.cargo/bin
export GO111MODULE=on
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
export PATH="$(yarn global bin):$PATH"

export PATH="$PATH:$HOME/emsdk-portable"
export PATH="$PATH:$HOME/emsdk-portable/clang/fastcomp/build_incoming_64/bin"
export PATH="$PATH:$HOME/emsdk-portable/emscripten/incoming"

export PATH=$PATH:$HOME/.local/bin

# export CHROME_BIN=google-chrome-unstable

# alias preview="fzf --preview 'bat --color \"always\" {}'"
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

#alias cat='bat'
#alias ping='prettyping --nolegend'
#alias top="htop"
alias k=kubectl


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
