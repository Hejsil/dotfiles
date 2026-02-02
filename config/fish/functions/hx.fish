function hx --wraps='helix' --description 'alias hx=helix'
    if type -q helix
        command helix $argv
    end
    command hx $argv
end
