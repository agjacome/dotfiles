function fish_prompt
    if test $status -ne 0
        set_color red
    end

    if fish_is_root_user
        echo -n ' '
    else
        echo -n ' '
    end

    set_color normal
end
