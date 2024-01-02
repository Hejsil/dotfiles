#!/usr/bin/env bash
BASH_BINARY="$(which bash)"
PREVIEW_ID="fzfpreview"

curr_preview_file=$(mktemp -p /tmp fzfimg-file.XXXXXXXXXX)
export curr_preview_file

function draw_preview {
    stty </dev/tty size | {
        read -r _ TERMINAL_COLUMNS
        X=$((TERMINAL_COLUMNS - COLUMNS - 2))
        Y=1

        curr_preview=$(cat "$curr_preview_file")
        next_preview="$X $Y $COLUMNS $LINES ${*}"
        if [ "$curr_preview" != "$next_preview" ]; then
            ueberzug cmd -s "$socket" \
                -a add -i "${PREVIEW_ID}" \
                -x "$X" -y "$Y" \
                --max-width "${COLUMNS}" --max-height "${LINES}" \
                -f "${@}" >/dev/null
            printf "%s" "$next_preview" >"$curr_preview_file"
        fi
    }
}

ub_pid_file=$(mktemp -p /tmp fzfimg-pid.XXXXXXXXXX)
ueberzug layer -o x11 --no-stdin --pid-file "$ub_pid_file" --silent --use-escape-codes </dev/null >/dev/null
ub_pid=$(cat "$ub_pid_file")

export -f draw_preview
export socket="/tmp/ueberzugpp-$ub_pid.socket"
SHELL="${BASH_BINARY}" \
    fzf --preview "draw_preview {}" \
    "${@}"

ueberzug cmd -s "$socket" -a exit >/dev/null
rm "$curr_preview_file"
