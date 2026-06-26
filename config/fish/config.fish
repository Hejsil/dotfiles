if status is-interactive
    if type -q atuin
        atuin init fish | source
    end
    if type -q carapace
        carapace _carapace | source
    end
    if type -q starship
        starship init fish | source
    end
    if type -q zoxide
        zoxide init fish | source
    end
    if type -q dasel
        dasel completion fish | source
    end
    if type -q direnv
        direnv hook fish | source
    end
    if type -q aur-scanner
        source /usr/share/aur-scan/integration.fish
    end
end
