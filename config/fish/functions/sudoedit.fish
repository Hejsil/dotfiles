function sudoedit --wraps=sudoedit --description 'alias sudoedit=sudoedit'
    set editor $(command -v "$EDITOR")
    EDITOR=$editor command sudoedit $argv
end
