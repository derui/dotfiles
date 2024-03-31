$env.config = {
  show_banner: false

  color_config: {
    hints: light_gray
  }

  keybindings : [
    # fzfで履歴の検索を行う
    {
      name: fuzzy_history
      modifier: control
      keycode: char_r
      mode: [emacs, vi_normal, vi_insert]
      event: [
        {
          send: ExecuteHostCommand
          cmd: "commandline (
            history
              | get command
              | uniq
              | reverse
              | str join (char -i 0)
              | fzf --scheme=history --read0 --layout=reverse --height=40% -q (commandline)
              | decode utf-8
              | str trim
          )"
        }
      ]
    }
    {
      name: ghq_history
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: [
        {
          send: ExecuteHostCommand
          cmd: "commandline (
            ghq list --full-path
              | fzf --height=40% -q (commandline)
              | decode utf-8
              | cd $in
          )"
        }
      ]
    }
  ]
}

# zellij
def start_zellij [] {
  if 'ZELLIJ' not-in ($env | columns) {
    if 'ZELLIJ_AUTO_ATTACH' in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == 'true' {
      zellij attach -c
    } else {
      zellij
    }

    if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
      exit
    }
  }
}

start_zellij

# starshipを実行する
source ~/.config/nushell/starship.nu
