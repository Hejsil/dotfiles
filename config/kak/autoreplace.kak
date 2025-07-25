define-command define-auto-replace -params 4 -docstring "Sets up hooks that will automatically replace `find` with `replace` when typing in insert mode" %{
    evaluate-commands %sh{
        name="auto-replace-$1"
        scope=$2
        find=$3
        replace=$4

        c0=$(expr substr "$find" 1 1)
        echo "hook -group '$name' $scope InsertChar '$c0' %{"
        echo "remove-hooks $scope '$name'"

        seq 2 "${#find}" | while read i; do
            c="$(expr substr "$find" $i 1)"
            echo "hook -group '$name' $scope InsertChar '[^$c]' %{"
            echo "remove-hooks $scope '$name'"
            echo "define-auto-replace '$name' '$scope' '$find' '$replace'"
            echo "}"
            echo "hook -group '$name' $scope InsertDelete '.*' %{"
            echo "remove-hooks $scope '$name'"
            echo "define-auto-replace '$name' '$scope' '$find' '$replace'"
            echo "}"
            echo "hook -group '$name' $scope InsertMove '.*' %{"
            echo "remove-hooks $scope '$name'"
            echo "define-auto-replace '$name' '$scope' '$find' '$replace'"
            echo "}"
            echo "hook -group '$name' $scope ModeChange '.*' %{"
            echo "remove-hooks $scope '$name'"
            echo "define-auto-replace '$name' '$scope' '$find' '$replace'"
            echo "}"

            echo "hook -group '$name' $scope InsertChar '$c' %{"
            echo "remove-hooks $scope '$name'"
        done

        find_count=$(printf '%s' "$find" | wc -c)
        echo "set-register 'l' '$replace'"
        echo "execute-keys '<a-;>h'"

        if [ "$find_count" -gt 1 ]; then
            echo "execute-keys '<a-;>$((find_count - 1))H'"
        fi

        echo "execute-keys '<a-;>\"lR'"

        cursor_symbol='¤'
        if printf '%s' "$replace" | grep "$cursor_symbol" >/dev/null; then
            echo "execute-keys '<a-;>s$cursor_symbol<ret><a-;>d'"
        else
            echo "execute-keys '<a-;><a-:><a-;>l'"
        fi
        echo "define-auto-replace '$name' '$scope' '$find' '$replace'"

        seq 1 "${#find}" | while read i; do
            echo "}"
        done
        # }
    }
}

hook -group filetype-zig-auto-replace global BufSetOption filetype=zig %{
    define-auto-replace zig-for buffer ':for' 'for (¤) |item| {}'
    define-auto-replace zig-it buffer ':it' 'var it = ¤; while (it.next()) |item| {}'
    define-auto-replace zig-while buffer ':while' 'while (¤) {}'

    define-auto-replace zig-arena buffer ':arena' 'var arena_state = std.heap.ArenaAllocator.init(¤);
const arena = arena_state.allocator();
defer arena_state.deinit();'
}

hook -group filetype-c-auto-replace global BufSetOption filetype=(c|cpp) %{
    define-auto-replace c-for buffer ':for' 'for (size_t i = 0; i < ¤; i++) {}'
    define-auto-replace c-while buffer ':while' 'while (¤) {}'
}

hook -group filetype-python-auto-replapythone global BufSetOption filetype=python %{
    define-auto-replace python-def buffer ':def' 'def ¤():'
    define-auto-replace python-for buffer ':for' 'for item in ¤:'
    define-auto-replace python-init buffer ':init' 'def __init__(self):'
}
