#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
SYMLINK="symlink."

link() {
    INFOLDER=$1
    OUTFOLDER=$2

    for FILE in $(find "$SCRIPTPATH/$INFOLDER" -maxdepth 1 -name "$SYMLINK*"); do
        NAME=$(basename "$FILE")
        OUT="$OUTFOLDER/${NAME#$SYMLINK}"
        echo "$OUT"


        ln -sni "$FILE" "$OUT" || \
            case "$(printf "yes\\nno\\n" | dmenu -b -l 2 -p "Could not create symlink '$OUT'. Sudo?")" in
                "yes")
                    sudo ln -sni "$FILE" "$OUT"
                    ;;
            esac
    done
}

link "home" "$HOME"

git config --global core.excludesfile "$HOME/.gitignore"
