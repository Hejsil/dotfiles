function gl --wraps='git log --graph --oneline' --description 'alias gl=git log --graph --oneline'
  git log --graph --oneline $argv
        
end
