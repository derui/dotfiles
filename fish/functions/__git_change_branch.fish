
function __git_change_branch
    set finder (__select_finder)

    git branch -a --no-color | string trim --chars="* " | awk '
    {
    if (match($0, /^remotes\//))
      print "remote\t" substr($0, RLENGTH+1);
    else print "local\t" $0;
    }' | \
    $finder | read -l selected_branch
    set selected_branch (eval string split "\t" $selected_branch)

    if test -n $selected_branch[2]
        # need variable expansion
        git switch $selected_branch[2]
        commandline -f repaint
    end

end
