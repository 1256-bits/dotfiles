# aliases
alias spS = sudo pacman -Syu
alias spR = sudo pacman -Rns
alias yay = yay --sudoloop
alias get-dirs = where type == "dir" or type == "symlink"
alias get-files = where type == "file"

alias vim = nvim
alias cat = bat
alias grep = rg

alias lf = lfrun

alias D = DRI_PRIME=1
alias mv = mv -iv
alias cp = cp -iuv

# custom fucntions
def not-empty [] { not ($in | is-empty) }

# startup commands
if (which tmux | not-empty) and ($env.TERM !~ "screen|tmux") {
    exec tmux
}
