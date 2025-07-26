define-command str-head-tail -params 3 -docstring '<str> <head-opt> <tail-opt>' %{
    evaluate-commands -save-regs 'lht' %{
        evaluate-commands -draft %{
            edit -scratch '*tmp*'
            set-register 'l' %arg{1}
            execute-keys '"lP<a-semicolon>;"hy%d'
            try %{
                execute-keys '"lP'
                execute-keys 's..<ret>'
                execute-keys '%d"lP<a-semicolon>L"ty'
            }
            execute-keys '%d'
        }
        set-option buffer %arg{2} %reg{h}
        set-option buffer %arg{3} %reg{t}
    }
}

define-command str-escape-regex -params 2 -docstring '<str> <res-opt>' %{
    evaluate-commands -save-regs 'l' %{
        evaluate-commands -draft %{
            edit -scratch '*tmp*'
            set-register 'l' %arg{1}
            execute-keys '"lP'
            try %{
                execute-keys 's[\\\[\*\+\?\|\{\}\(\)\]\[\^\$\.]<ret>i\<esc>'
            }
            execute-keys '%H"ly%d'
        }
        set-option buffer %arg{2} %reg{l}
    }
}

declare-option -hidden str auto_replace_tmp
declare-option -hidden str auto_replace_head
declare-option -hidden str auto_replace_tail

define-command define-auto-replace -params 3 -docstring "Sets up hooks that will automatically replace `find` with `replace` when typing in insert mode" %{
    define-auto-replace-reset %arg{1} %arg{2} %arg{3} %arg{2}
}

define-command define-auto-replace-inner -hidden -params 4 -docstring '<name> <find> <replace> <tail>' %{
    str-head-tail %arg{4} auto_replace_head auto_replace_tail
    str-escape-regex %opt{auto_replace_head} auto_replace_head
    define-auto-replace-shell %arg{1} %arg{2} %arg{3} %opt{auto_replace_head} %opt{auto_replace_tail}
}

define-command define-auto-replace-reset -hidden -params 4 -docstring '<name> <find> <replace> <tail>' %{
    remove-hooks buffer "auto-replace-%arg{1}"
    define-auto-replace-inner %arg{1} %arg{2} %arg{3} %arg{4}
}

define-command define-auto-replace-reset-hooks -hidden -params 4 \
    -docstring '<name> <find> <replace> <tail>' \
%{
    str-head-tail %arg{4} auto_replace_head auto_replace_tail
    str-escape-regex %opt{auto_replace_head} auto_replace_head

    set-option buffer auto_replace_tmp "define-auto-replace-reset '%arg{1}' '%arg{2}' '%arg{3}' '%arg{2}'"
    hook -group "auto-replace-%arg{1}" buffer InsertChar   "[^%opt{auto_replace_head}]" "%opt{auto_replace_tmp}"
    hook -group "auto-replace-%arg{1}" buffer InsertDelete ".*"                         "%opt{auto_replace_tmp}"
    hook -group "auto-replace-%arg{1}" buffer InsertMove   ".*"                         "%opt{auto_replace_tmp}"
}

define-command define-auto-replace-shell -params 5 %{
    evaluate-commands %sh{
        name=$1
        find=$2
        replace=$3
        head=$4
        tail=$5

        echo "hook -group 'auto-replace-$name' buffer InsertChar '$head' %{"
        echo "remove-hooks buffer 'auto-replace-$name'"

        if [ -z "$tail" ]; then
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
            echo "define-auto-replace-reset '$name' '$find' '$replace' '$find'"
        else
            echo "define-auto-replace-reset-hooks '$name' '$find' '$replace' '$tail'"
            echo "define-auto-replace-inner '$name' '$find' '$replace' '$tail'"
        fi
        echo "}"
    }
}

hook -group filetype-zig-auto-replace global BufSetOption filetype=zig %{
    define-auto-replace zig-gpa 'gpa:' 'gpa: std.mem.Allocator'
    define-auto-replace zig-str 'str:' 'str: []const u8'
    define-auto-replace zig-writer 'writer:' 'writer: *std.io.Writer'
    define-auto-replace zig-test '()' 'writer: *std.io.Writer'

    define-auto-replace zig-for1 'for(' 'for (¤) |item| {}'
    define-auto-replace zig-for2 'for (' 'for (¤) |item| {}'
    define-auto-replace zig-while1 'while(' 'while (¤) {}'
    define-auto-replace zig-while2 'while (' 'while (¤) {}'
    define-auto-replace zig-if1 'if(' 'if (¤) {}'
    define-auto-replace zig-if2 'if (' 'if (¤) {}'
    define-auto-replace zig-whileit1 'whileit(' 'var it = ¤; while (it.next()) |item| {}'
    define-auto-replace zig-whileit2 'whileit (' 'var it = ¤; while (it.next()) |item| {}'

    define-auto-replace zig-arena 'var arena' 'var arena_state = std.heap.ArenaAllocator.init(¤);
const arena = arena_state.allocator();
defer arena_state.deinit();'
}
