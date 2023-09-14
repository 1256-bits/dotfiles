# aliases
alias vim = nvim
alias cat = bat
alias lf = lfrun

# custom fucntions
def not-empty [] { not ($in | is-empty) }

# startup commands
if (which tmux | not-empty) and ($env.TERM !~ "screen|tmux") {
    exec tmux
}
