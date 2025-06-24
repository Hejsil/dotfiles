function yay --wraps=yay --description 'alias yay=yay'
    command yay $argv
    command yay -Qqe >"$XDG_CONFIG_HOME/installed-programs"
end
