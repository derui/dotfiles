def "nu-complete git branches" [] {
    git branch
    | lines
    | filter {|x| not ($x | str starts-with '*')}
    | each {|x| $x | str trim}
}

# aliasを前提にした switchの提供
export def "git s" [
  branch:  string@"nu-complete git branches"
] {
   ^git switch $branch
}
