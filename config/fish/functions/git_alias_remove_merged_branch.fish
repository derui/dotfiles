function git_alias_remove_merged_branch
    git branch -vv | grep ': gone]' | grep -v '*' | awk '{ print $1; }' | xargs -r git branch -d
end
