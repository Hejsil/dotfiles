function hx --wraps='helix' --description 'alias hx=helix'
    if type -q helix
        command helix $argv
    else
        command hx $argv
    end
end
