function fish_prompt
    # Last command status
    if test $status -eq 0
        set_color green
        echo -n "✓ "
    else
        set_color red
        echo -n "✗ "
    end

    # Current folder
    set_color blue
    echo -n (basename (pwd))

    # Git branch
    if type git > /dev/null 2>&1; and git rev-parse --is-inside-work-tree > /dev/null 2>&1
        if git rev-parse --is-bare-repository 2>/dev/null | grep -q 'true'
            set_color magenta
            echo -n " (Bare)"
        else
            set_color green
            echo -n " ("(git branch | grep "\*" | sed "s/* //")")"
        end
    end

    set_color normal
    echo -n " > "
end

