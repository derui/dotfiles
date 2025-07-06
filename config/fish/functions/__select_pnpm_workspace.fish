function __select_pnpm_workspace -d "Search pnpm workspace packages with fuzzy finder and move to selected directory"
    set finder (__select_finder)
    if test $status -ne 0
        echo "Error: No fuzzy finder found (fzf or peco required)"
        return 1
    end

    commandline | read -l buffer
    
    if not test -f "pnpm-workspace.yaml"
        echo "Error: pnpm-workspace.yaml not found in current directory"
        return 1
    end
    
    set workspace_dirs (pnpm list --recursive --depth 0 --parseable 2>/dev/null | grep -v "^$PWD\$" | sed "s|$PWD/||g")
    
    if test (count $workspace_dirs) -eq 0
        echo "Error: No workspace packages found"
        return 1
    end
    
    printf "%s\n" $workspace_dirs | \
        $finder --query "$buffer" | \
        read -l selected_dir
    
    if test -n "$selected_dir"
        commandline "cd $selected_dir"
        commandline -f execute
    end
    
    commandline -f repaint
end