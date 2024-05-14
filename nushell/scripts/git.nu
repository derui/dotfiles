def "nu-complete git branches" [] {
    git branch
    | lines
    | filter {|x| not ($x | str starts-with '*')}
    | each {|x| $x | str trim}
}

# aliasを前提にした switchの提供
export def "g s" [
  branch:  string@"nu-complete git branches"
] {
   ^git switch $branch
}

# aliasを前提にしたmerge済みbranchの削除
export def "g delete-orphan-branches" [
  --dry-run
] {
  git fetch --prune
  git checkout main
  | git for-each-ref refs/heads/ "--format=%(refname:short)"
  | lines
  | str trim
  | each {
    let branch = $in
    let mergeBase = (git merge-base main $branch out+err> /dev/null)
    let ret = (git cherry main (git commit-tree (git rev-parse $"($branch)^{tree}") -p $mergeBase -m _))

    if $ret == "-" {
        if $dry_run {
             $"$branch is merged into main and can be deleted"
        } else {
            git branch -D $branch
        }
    }
  } 
}
