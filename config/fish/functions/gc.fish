function gc --wraps='git commit' --description 'alias gc=git commit'
    git commit --verbose $argv
end
