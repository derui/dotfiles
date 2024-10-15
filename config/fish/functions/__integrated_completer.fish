
set -g __integrated_completer_list git_branch

function __local_completer_git_branch
    set finder (__select_finder)

    git branch -a --no-color | grep -v HEAD | string trim --chars="* " | awk '
    {
    if (match($0, /^remotes\//))
      print "remote\t" substr($0, RLENGTH+1);
    else print "local\t" $0;
    }' | \
    $finder | read -l selected_branch
    set selected_branch (eval string split "\t" $selected_branch)

    if test -n "$selected_branch[2]"
        # need variable expansion
        commandline -i $selected_branch[2]
    end

end

function __integrated_completer
    set finder (__select_finder)
    echo $__integrated_completer_list | \
    $finder | \
    read -l selected_completer

    if test -n "$selected_completer"
        eval "__local_completer_$selected_completer"
    end

    commandline -f repaint
end
