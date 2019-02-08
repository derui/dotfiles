function __select_ghq_cd
    set finder (__select_finder)
    commandline | read -l buffer
    ghq list --full-path | \
          sed -e "s|$HOME/||g" | \
          $finder --query "$buffer" | \
          read -l repository_path

    if test -n "$repository_path"
        commandline "cd ~/$repository_path"
        commandline -f execute
    end

    commandline -f repaint
end
