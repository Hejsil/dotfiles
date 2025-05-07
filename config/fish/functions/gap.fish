function gap --wraps='git add --patch' --description 'alias gap=git add --patch'
    git add --patch $argv
end
