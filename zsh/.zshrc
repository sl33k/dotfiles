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

#add perlbrew path to PATH
export PATH="$PATH:$HOME/local/bin"
#perlbrew completion
if [[ -d ~/perl5/perlbrew/etc/bashrc ]]
then
    source ~/perl5/perlbrew/etc/bashrc
fi

# Set Language manually 
 export LANG=en_US.UTF-8

# Set default editor
export EDITOR='vim'


# Node Version Manager startup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#keychain, only run when inside x console
if xhost &> /dev/null
then
    eval $(keychain --agents ssh,gpg --quiet --eval id_rsa id_ecdsa 54D705CFA598350FD65894BDC09A4FE22EE94CB4)
else
    if [[ -f /usr/bin/herbstluftwm  && ! -f /usr/bin/ligthdm ]]
    then
       exec startx
    fi
fi


[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
