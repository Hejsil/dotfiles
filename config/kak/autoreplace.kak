define-command define-auto-replace -params 4 -docstring "Sets up hooks that will automatically replace `find` with `replace` when typing in insert mode" %{
    evaluate-commands %sh{
        name="auto-replace-$1"
        scope=$2
        find=$3
        replace=$4

        printf '%s' "$find" | grep -o . | head -n1 | while read c; do
            echo "hook -group '$name' $scope InsertChar '$c' %{"
            echo "remove-hooks $scope '$name'"
        done

        printf '%s' "$find" | grep -o . | tail -n+2 | while read c; do
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
        echo "execute-keys '<a-;><a-:><a-;>l'"
        echo "define-auto-replace '$name' '$scope' '$find' '$replace'"

        printf '%s' "$find" | grep -o . | while read c; do
            echo "}"
        done
        # }
    }
}
