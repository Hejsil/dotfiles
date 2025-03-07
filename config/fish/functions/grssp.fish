function grssp --wraps='git restore --staged --patch' --description 'alias grssp=git restore --staged --patch'
  git restore --staged --patch $argv
        
end
