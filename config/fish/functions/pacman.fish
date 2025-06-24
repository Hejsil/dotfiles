function pacman --wraps=pacman --description 'alias pacman=pacman'
    command pacman $argv

    mkdir -p "$XDG_CONFIG_HOME/pkgs"
    command pacman -Qnqe >"$XDG_CONFIG_HOME/pkgs/arch"
    command pacman -Qmqe >"$XDG_CONFIG_HOME/pkgs/aur"
end
