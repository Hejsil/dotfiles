define-command define-auto-replace -params 4 -docstring "Sets up hooks that will automatically replace `find` with `replace` when typing in insert mode" %{
    evaluate-commands %sh{
        name="auto-replace-$1"
        scope=$2
        find=$3
        replace=$4
        redefine="$name-redefine"

        hook="hook -group '$name' $scope"
        remove_hooks="remove-hooks $scope '$name'"

        sed_expr="${sed_expr}$hook InsertChar '\\1' %{\n"
        sed_expr="${sed_expr}remove-hooks $scope '$name'\n"
        sed_expr="${sed_expr}$hook InsertChar '[^\\1]' %{\n"
        sed_expr="${sed_expr}$remove_hooks\n"
        sed_expr="${sed_expr}$redefine\n"
        sed_expr="${sed_expr}}\n"
        sed_expr="${sed_expr}$hook InsertDelete '.*' %{\n"
        sed_expr="${sed_expr}$remove_hooks\n"
        sed_expr="${sed_expr}$redefine\n"
        sed_expr="${sed_expr}}\n"
        sed_expr="${sed_expr}$hook InsertMove '.*' %{\n"
        sed_expr="${sed_expr}$remove_hooks\n"
        sed_expr="${sed_expr}$redefine\n"
        sed_expr="${sed_expr}}\n"
        sed_expr="${sed_expr}$hook ModeChange '.*' %{\n"
        sed_expr="${sed_expr}$remove_hooks\n"
        sed_expr="${sed_expr}$redefine\n"
        sed_expr="${sed_expr}}\n"
        # }

        echo "define-command $redefine -override -hidden %{"
        echo "define-auto-replace '$name' '$scope' '$find' '$replace'"
        echo "}"
        printf "%s" "$find" | sed -E 's/(.)/\1\n/g' | escape-regex | sed -E "s#^(.*)\$#${sed_expr}#g"

        echo "set-register 'l' '$replace'"
        echo "execute-keys '<a-;>h'"

        find_count=${#find}
        if [ "$find_count" -gt 1 ]; then
            echo "execute-keys '<a-;>$((find_count - 1))H'"
        fi

        echo "execute-keys '<a-;>\"lR'"
        echo "try %{"
        echo "    execute-keys '<a-;>s¤<ret><a-;>d'"
        echo "} catch %{"
        echo "    execute-keys '<a-;><a-:><a-;>l'"
        echo "}"

        # {
        echo "$remove_hooks"
        echo "$redefine"
        printf "%s" "$find" | sed 's/./}/g'
    }
}

hook -group filetype-zig-auto-replace global BufSetOption filetype=zig %{
    define-auto-replace zig-gpa buffer 'gpa:' 'gpa: std.mem.Allocator'
    define-auto-replace zig-str buffer 'str:' 'str: []const u8'
    define-auto-replace zig-writer buffer 'writer:' 'writer: *std.io.Writer'

    define-auto-replace zig-for1 buffer 'for(' 'for (¤) |item| {}'
    define-auto-replace zig-for2 buffer 'for (' 'for (¤) |item| {}'
    define-auto-replace zig-while1 buffer 'while(' 'while (¤) {}'
    define-auto-replace zig-while2 buffer 'while (' 'while (¤) {}'
    define-auto-replace zig-if1 buffer 'if(' 'if (¤) {}'
    define-auto-replace zig-if2 buffer 'if (' 'if (¤) {}'
    define-auto-replace zig-whileit1 buffer 'whileit(' 'var it = ¤; while (it.next()) |item| {}'
    define-auto-replace zig-whileit2 buffer 'whileit (' 'var it = ¤; while (it.next()) |item| {}'

    define-auto-replace zig-arena buffer 'var arena' 'var arena_state = std.heap.ArenaAllocator.init(¤);
const arena = arena_state.allocator();
defer arena_state.deinit();'
}
