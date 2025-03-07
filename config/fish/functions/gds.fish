function gds --wraps='git difftool --staged' --description 'alias gds=git difftool --staged'
  git difftool --staged $argv
        
end
