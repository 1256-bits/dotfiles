### Aliases ###

alias spS = sudo pacman -S
alias spR = sudo pacman -Rns
alias yay = yay --sudoloop
alias get-dirs = where type == "dir" or type == "symlink"
alias get-files = where type == "file"
alias eza = eza --group-directories-first --icons
alias oldpwd = cd $env.OLDPWD

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


### Startup commands ###
if (which tmux | not-empty) and ($env.TERM !~ "screen|tmux") {
  let last_session = ^tmux ls 
    | lines
    | parse "{name}: {windows} windows (created {date}){attached}"
    | last
    
  if ($last_session | is-empty) { exec tmux }

  if ($last_session.attached == "") {
      exec tmux attach-session -t $last_session.name
  }
  exec tmux
}

