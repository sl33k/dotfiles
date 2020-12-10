# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

# Make sure to use double quotes to prevent shell expansion
zplug "zsh-users/zsh-autosuggestions"
zplug "hlissner/zsh-autopair", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "themes/terminalparty", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh 
zplug "plugins/tmuxinator", from:oh-my-zsh 
zplug "plugins/tmux", from:oh-my-zsh 
zplug "plugins/history", from:oh-my-zsh
zplug "tarrasch/zsh-bd"

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

### Plugin settings
# auto start tmux on zsh start
export ZSH_TMUX_AUTOSTART_ONCE=true
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_FIXTERM=true

## set correct keyboard layout on linux
if [[ $OSTYPE == "linux-gnu" ]]; then
    setxkbmap -layout us -variant altgr-intl -option "caps:escape"
fi

### home/del/ins 
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -v -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -v -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -v -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -v -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -v -- "${key[Delete]}"    delete-char
[[ -n "${key[Left]}"      ]] && bindkey -v -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -v -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -v -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -v -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -v -- "${key[ShiftTab]}"  reverse-menu-complete "${terminfo[khome]}" beginning-of-line

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${key[Up]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${key[Up]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${key[Down]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${key[Down]}" down-line-or-beginning-search
fi

# bind history search
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^F" history-incremental-pattern-search-forward

# commit zplug load
zplug load

###  path modifications
if [[ -d $HOME/local/bin ]]; then
    export PATH="$HOME/local/bin:$PATH"
fi

### misc settings
export LANG=en_US.UTF-8
export EDITOR='vim'

###  Aliases
# vimtex support (only if vim is compiled with +clientserver)
vim_version=$(vim --version)
if echo "$vim_version" | grep -ql "+clientserver"; then
    alias vim="vim --servername vim"
fi

# ls colors
if [[ $OSTYPE == "darwin"* ]]; then
    alias ls="ls -G"
elif [[ $OSTYPE == "linux-gnu" ]]; then
    alias ls="ls --color=auto"
fi

#keychain, only run when installed and on unix only if in X environment 
if command -v keychain > /dev/null; then
    if [[ ($OSTYPE == "linux-gnu" && $(xhost &> /dev/null)) || $OSTYPE == "darwin"* ]]; then
        eval $(keychain --agents ssh,gpg --quiet --ignore-missing --eval id_rsa id_ecdsa 54D705CFA598350FD65894BDC09A4FE22EE94CB4)
    fi
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_ignore_dups

setopt autocd
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt share_history

if zplug check "zsh-users/zsh-history-substring-search"; then
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey "^[[1;5A" history-substring-search-up
    bindkey "^[[1;5B" history-substring-search-down
fi
