function dipm --wraps=dipm --description 'alias dipm=dipm'
    command dipm $argv
    command dipm list installed | cut -f1 >"$XDG_CONFIG_HOME/dipm-installed-programs"
end
