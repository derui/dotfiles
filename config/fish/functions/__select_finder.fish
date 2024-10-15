function __select_finder
    set finders 'fzf' 'peco'

    for f in $finders
        if test -x (which $f)
            echo "$f"
            return 0
        end
    end

    return 1
end
