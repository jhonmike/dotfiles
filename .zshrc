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

# Tell antigen that you're done.
antigen apply

# User configuration

export VISUAL="vim"
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/Projects/contaazul/contaazul-cli/index.sh
alias chrome=google-chrome-unstable

export GOPATH="$HOME/Projects/go"
export PATH="$PATH:$GOPATH/bin"

source $HOME/.cargo/env
export PATH="$PATH:$HOME/emsdk-portable"
export PATH="$PATH:$HOME/emsdk-portable/clang/fastcomp/build_incoming_64/bin"
export PATH="$PATH:$HOME/emsdk-portable/emscripten/incoming"

export CHROME_BIN=google-chrome-unstable

export PATH=$PATH:~/.local/bin

