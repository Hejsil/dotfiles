define-command -override autoalign -docstring '' %{
    evaluate-commands -draft %{
        # Find all 'autoalign begin' in the buffer
        execute-keys '%sautoalign begin .<ret>;'

        # For each selection ...
        evaluate-commands -itersel %{
            execute-keys 'Gl"py' # Select and copy pattern to register `p`
            execute-keys 'jgh' # Goto beginning of next line
            execute-keys '?autoalign end<ret>' # Select everything until `autoalign end`
            execute-keys %sh{
                # Construct a command that only selects all lines that containers the pattern.
                # If we have the pattern `|||`, then we search for `[^\n]*\|[^\n]*\|[^\n]*\|`,
                # however, we escape everything in the pattern to hex escape (`\x00`). This is the
                # easiest way escape a string for regex.
                # The final search string is therefor `[^\n]*\x7c[^\n]*\x7c[^\n]*\x7c`.
                printf 's'
                printf '%s' "$kak_reg_p" |
                    xxd -ps |
                    fold -w 2 |
                    sed 's/^/[^\\n]*\\x/' |
                    tr -d '\n'
                printf '<ret>'
            }

            # autoalign takes over inserting whitespace for the selection, so we replace multiple
            # whitespaces after eachother with just a single whitespace before aligning.
            try %{ execute-keys -draft 'giGls\s\s+<ret>Hd' } catch %{}
            execute-keys 'gh' # Finally, go to beginning of each line
            execute-keys %sh{
                # Construct keys that, for each character in the pattern, finds that character
                # (`fc`) and use kakounes builtin aligner `&`.
                printf "%s" "$kak_reg_p" | sed -E 's/(.)/f\1;\&/g'
            }
        }
    }
}

hook global BufWritePre .* %{
    try autoalign catch %{}
}
