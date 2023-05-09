#!/usr/bin/env bash
BASH_BINARY="$(which bash)"
PREVIEW_ID="fzfpreview"

function draw_preview {
    stty </dev/tty size | {
        read -r _ TERMINAL_COLUMNS
        X=$((TERMINAL_COLUMNS - COLUMNS - 2))
        Y=1
        ueberzug cmd -s "/tmp/ueberzugpp-$ub_pid.socket" \
            -a add -i "${PREVIEW_ID}" \
            -x "$X" -y "$Y" \
            --max-width "${COLUMNS}" --max-height "${LINES}" \
            -f "${@}"
    }
}

ueberzug layer -o x11 --no-stdin --silent --use-escape-codes &
ub_pid=$!
trap "kill $ub_pid" EXIT

export -f draw_preview
export ub_pid
SHELL="${BASH_BINARY}" \
    fzf --preview "draw_preview {}" \
    "${@}"
