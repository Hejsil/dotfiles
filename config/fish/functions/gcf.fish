function gcf --wraps='git commit --fixup=commit' --description 'alias gpf=git commit --fixup=commit'
    git log --oneline | fzf | cut -f1 -d ' ' | nargs -I% git commit --fixup=% $argv
end
