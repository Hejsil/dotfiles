function cd --wraps=yay --description 'alias yay=yay'
    yay $argv
    yay -Qqe >"$XDG_CONFIG_HOME/installed-programs"
    rg -xF -f \
        "$XDG_CONFIG_HOME/essential-programs" \
        "$XDG_CONFIG_HOME/installed-programs" |
        sponge "$XDG_CONFIG_HOME/essential-programs"
    rg -vxF -f \
        "$XDG_CONFIG_HOME/essential-programs" \
        "$XDG_CONFIG_HOME/installed-programs" |
        sponge "$XDG_CONFIG_HOME/installed-programs"
end
