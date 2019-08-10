# utility function to sanitize PATH-like specifications
function sanitize_path
{
    # Do not allow repeated elements, repeated, starting, or ending `:`.
    echo -n "$1" | awk -v 'RS=:' -v 'ORS=:' '!seen[$0]++' \
                 | sed 's/::*/:/g' | sed 's/^://' | sed 's/:$//'
}

export PATH="$(sanitize_path "$HOME/bin:$PATH")"

alias git-sh='exec git-sh'
alias tree='tree -I .git'
