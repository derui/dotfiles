
# fzfを利用して履歴からコマンドを選択する
export def get-history [] {
  commandline (
    history
      | get command
      | uniq
      | reverse
      | str join (char -i 0)
      | fzf --scheme=history --read0 --layout=reverse --height=40% -q (commandline)
      | decode utf-8
      | str trim
  )
}

# ghqで管理しているリポジトリをfzfで選択して移動する
# --envがないと、cdで変更してもシェルのカレントディレクトリが変わらない
export def --env ghq [] {
  ^ghq list --full-path | fzf --layout=reverse --height=40% | decode utf-8 | str trim | cd $in
}

export def main [] {}
