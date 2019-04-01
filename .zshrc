source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Translate plug.
antigen bundle soimort/translate-shell

# Load the theme.
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply

# User configuration

export VISUAL="vim"
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:$HOME/.cargo/bin
export GOPATH=$HOME/Projects/go
export PATH=$PATH:$GOPATH/bin

export PATH="$PATH:$HOME/emsdk-portable"
export PATH="$PATH:$HOME/emsdk-portable/clang/fastcomp/build_incoming_64/bin"
export PATH="$PATH:$HOME/emsdk-portable/emscripten/incoming"

export PATH=$PATH:$HOME/.local/bin

export CHROME_BIN=google-chrome-unstable

alias preview="fzf --preview 'bat --color \"always\" {}'"
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

#alias cat='bat'
#alias ping='prettyping --nolegend'
#alias top="htop"

