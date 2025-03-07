function kak --wraps='tmux new-session kakoune' --description 'alias kak=tmux new-session kakoune'
  tmux new-session kakoune $argv
        
end
