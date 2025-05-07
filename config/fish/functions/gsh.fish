function gsh --wraps='git stash' --description 'alias gsh=git stash'
    git stash $argv
end
