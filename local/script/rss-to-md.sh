#!/bin/execlineb -s1
foreground {
    pipeline { tail -n +2 "$1" }
    head -n 1
}
foreground { echo }
pipeline { tail -n +4 "$1" }
pipeline { head -n 1 }
pipeline { sd "\\\\n" "" }
importas columns COLUMNS
w3m -T text/html -cols $columns
