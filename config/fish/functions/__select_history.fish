# pecoで検索する
function __select_history

    set finder (__select_finder)

    commandline | read -l buffer
    history | $finder --query "$buffer" | \
    read -l history_selected

    if test -n $history_selected
        commandline "$history_selected"
    end

    commandline -f repaint
end
