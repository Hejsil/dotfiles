#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

link() {
    INFOLDER=$1
    OUTFOLDER=$2

    for FILE in $(find "$SCRIPTPATH/$INFOLDER" -mindepth 1 -maxdepth 1); do
        NAME=$(basename "$FILE")
        OUT="$OUTFOLDER/${NAME#$SYMLINK}"
        echo "$FILE"
        echo "$OUT"


        ln -sni "$FILE" "$OUT" || \
            case "$(printf "yes\\nno\\n" | dmenu -b -l 2 -p "Could not create symlink '$OUT'. Sudo?")" in
                "yes")
                    sudo ln -sni "$FILE" "$OUT"
                    ;;
            esac
    done
}

link "symlink/home/" "$HOME"
link "symlink/.config/" "$HOME/.config"

git config --global core.excludesfile "$HOME/.gitignore"
