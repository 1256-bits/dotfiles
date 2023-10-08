### Aliases ###

alias spS = sudo pacman -Syu
alias spR = sudo pacman -Rns
alias yay = yay --sudoloop
alias get-dirs = where type == "dir" or type == "symlink"
alias get-files = where type == "file"
alias eza = eza --group-directories-first --icons

alias vim = nvim
alias cat = bat
alias grep = rg

alias lf = lfrun

alias D = DRI_PRIME=1
alias mv = mv -iv
alias cp = cp -iuv


### Custom functions ###

# Check if a pipeline input isn't empty
def not-empty [] { not ($in | is-empty) }
# List installed flatpaks in a table
def flatlist [] = { flatpak list | lines | split column -r '	' | rename name id version branch installation }
# Launch a flatpak
def flatrun [] = {
    let ignorelist = [Platform, Gtk3theme]
    let flatpaks = flatlist | where {|line| $ignorelist | all {|it| $line.id !~ $it }}
    let choice = $flatpaks | get name | to text | fzf
    bash -c $'flatpak run ($flatpaks | where name == $choice | get id | to text) & disown'
}


### Startup commands ###
if (which tmux | not-empty) and ($env.TERM !~ "screen|tmux") {
    exec tmux
}

