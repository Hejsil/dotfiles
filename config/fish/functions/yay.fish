function yay --wraps=yay --description 'alias yay=yay'
    command yay $argv

    mkdir -p "$XDG_CONFIG_HOME/pkgs"
    command pacman -Qnqe >"$XDG_CONFIG_HOME/pkgs/arch"
    command pacman -Qmqe >"$XDG_CONFIG_HOME/pkgs/aur"
end
