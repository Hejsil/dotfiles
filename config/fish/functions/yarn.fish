function cd --wraps=yarn --description 'alias yarn=yarn'
    yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config" $argv
end
