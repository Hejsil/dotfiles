function cd --wraps=z --description 'alias cd=z'
    z $argv
    timeout -k 0 0.1s eza
end
