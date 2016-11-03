# -*- mode:shell-script -*-

setopt   auto_list auto_param_slash list_packed rec_exact
unsetopt list_beep

# shellの単語分割を無効にする
unsetopt sh_wordsplit

# --prefix=/usrなどの時にも補完を有効にする。
setopt magic_equal_subst

# 先頭がスペースならヒストリーに追加しない。
setopt hist_ignore_space

# ベルを鳴らさない。
setopt no_beep

# 補完時にヒストリを自動的に展開する。
setopt hist_expand

# Share histories all zsh process
setopt share_history

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_all_dups

# ディレクトリ名だけで移動できるように
setopt auto_cd

# 自動的にpushdを実行するようになる。cd -[TAB]で移動履歴が出る。
setopt auto_pushd

# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_ignore_dups

# 自動的に末尾のslashを取り除く。
setopt auto_remove_slash

setopt print_eight_bit
# Ctrl+Q や Ctrl+Sによるフロー制御を行わないようにする
setopt no_flow_control

# 改行の無い出力をプロンプトで上書きするのを防ぐ
setopt no_prompt_cr

# glob展開時に大文字小文字を無視
setopt no_case_glob

# 右プロンプトに入力がきたら消す
setopt transient_rprompt

setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
setopt no_checkjobs          # ログアウト時にバックグラウンドジョブを確認しない
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
