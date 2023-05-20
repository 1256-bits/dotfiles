
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 0 numeric
zstyle :compinstall filename '/home/iris/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt autocd extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

PS1='%B%F{cyan}[%1~]$%f%b '

#package managment

alias spS="sudo pacman -S"
alias spR="sudo pacman -Rns"

#text editors

export EDITOR="nvim"
alias vim="nvim "
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export VISUAL="nvim"
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
#export PATH=$PATH:~/.emacs.d/bin
#export PATH=$PATH:~/.roswell/bin

##Edit .zshrc

alias rcedit="nvim ~/.zshrc"
alias rcreload="source ~/.zshrc"

#programs

##GNU rewrites
alias cat="bat"
alias ls="exa --group-directories-first --icons"
alias lss="exa -ls=size"
alias lsr="exa -lsr=size"
alias grep="rg"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

##other
alias D="DRI_PRIME=1"
alias rtw="cd ~/rtw88/ && sudo make install && sudo modprobe rtw_8723de"
alias mv="mv -iv"
alias o="xdg-open"
alias r="ranger"
alias dotfs="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

##VPN
alias wg-up="sudo wg-quick up ~/xeovo/xeovo-fi.conf"
alias wg-down="sudo wg-quick down ~/xeovo/xeovo-fi.conf"

#navigation

alias gdd="cd ~/Downloads"
alias gcf="cd ~/.config"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=~/.nvm/versions/node/v18.13.0/bin:$PATH
export PATH=~/.emacs.d/bin:$PATH

#plugins

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.local/share/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

eval "$(lua ~/z.lua/z.lua --init zsh)"
alias rm="rm -v"
