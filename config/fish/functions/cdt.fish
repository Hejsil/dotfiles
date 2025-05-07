function cdt --wraps=cd --description 'alias cdt=cd'
    cd "$(mktemp -d)"
end
