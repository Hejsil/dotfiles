function cd --wraps=dipm --description 'alias dipm=dipm'
    command dipm $argv
    command dipm list installed | sort | cut -f1 >"$XDG_CONFIG_HOME/dipm-installed-programs"
end
