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
alias cp = cp -iv

### Custom functions ###

# Check if a pipeline input isn't empty
def not-empty [] { not ($in | is-empty) }
# List installed flatpaks in a table
def flatlist [] = { flatpak list | lines | split column -r '	' | rename name id version branch installation }

# Rename files to their md5 hash
def md5-rename [glob] {
  glob $glob | each {|$input|
    let file = $input | path basename
    let name = $file | split row "." | drop | reverse | reduce {|$a, $b| ($a | into string) + ($b | into string)}
    let extension = $file | split row "." | last | into string
    open $file | hash md5 | mv $file $"($in).($extension)"
  }
}

# Launch bash shell with nvm loaded
# REPLACE WITH FNM
def nvm-shell [] {
    'export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
    | save -f /tmp/nvm-bashrc
    bash -rcfile /tmp/nvm-bashrc
    rm /tmp/nvm-bashrc
}

# df -h in nushell table format
def df [] {
  ^df -h | lines | drop nth 0 | split column -r '\s+' | rename Filesystem Size Used Avail Use% Path
}

# Cd to one of the currently mounted media devices
def --env media [] {
  let media_dir = df | where Path =~ $'/run/media/($env.USER)' | select Filesystem Avail Use% Path
  let index = $media_dir | each {|$rec| $"($rec | get Filesystem)    ($rec | get Avail)    ($rec | get Use%)"} | input list -i "  Filesystem  Avail  Use%"
  $media_dir | get $index | get Path | cd $in
}

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

