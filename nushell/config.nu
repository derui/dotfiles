
use fzf-commands.nu
use git.nu

$env.config = {
  show_banner: false

  color_config: {
    hints: light_gray
  }

  keybindings : [
    # fzfで履歴の検索を行う
    {
      name: fzf_ghq
      modifier: control
      keycode: char_r
      mode: [emacs, vi_normal, vi_insert]
      event: [
        {
          send: ExecuteHostCommand
          cmd: "fzf-commands get-history"
        }
      ]
    }
    # fzfでghqのlistを検索する
    {
      name: fzf_ghq
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: [
        {
          send: ExecuteHostCommand
          cmd: "fzf-commands ghq"
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

# alias
alias g = git

# starshipを実行する
source starship.nu
