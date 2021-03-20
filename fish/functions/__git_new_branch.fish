
function __git_new_branch
    read -P "New branch> " -l new_branch_name

    if test -n $new_branch_name
        command git switch -c $new_branch_name
        commandline -f repaint
    end

end
