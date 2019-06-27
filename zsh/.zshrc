# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bira"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8

# Set default editor
export EDITOR='vim'


if [ -d "$HOME/local/bin" ]
then
    export PATH="$PATH:$HOME/local/bin"
fi

alias gcc='gcc-8'
alias cc='gcc-8'
alias g++='g++-8'
alias c++='c++-8'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export PATH="/usr/local/Cellar/llvm/7.0.1/bin:$PATH"
export PATH="/usr/local/Cellar/vim/8.1.0800/bin:$PATH"

# opam configuration
test -r /Users/sl33k/.opam/opam-init/init.zsh && . /Users/sl33k/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
