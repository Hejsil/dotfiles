function dipm --wraps=dipm --description 'alias dipm=dipm'
    command dipm $argv

    mkdir -p "$XDG_CONFIG_HOME/pkgs"
    command dipm list installed | cut -f1 >"$XDG_CONFIG_HOME/pkgs/dipm"
end
