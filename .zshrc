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

# Load the theme.
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply

# User configuration

# You may need to manually set your language environment
export LANG=pt_BR.UTF-8
setxkbmap -model abnt2 -layout br -variant abnt2

export VISUAL="vim"
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

## Compufacil
export CLIPP_PATH=$HOME/Projetos/Compufacil/compufacil
source $CLIPP_PATH/Cli/cpf-variables
export PATH=$PATH:$CLIPP_PATH/Cli

## GoLang
export GOPATH=$HOME/Projetos/Go
export PATH=$PATH:$GOPATH/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
