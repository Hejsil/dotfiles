function gds --wraps='git diff --staged' --description 'alias gds=git diff --staged'
    git diff --staged $argv
end
