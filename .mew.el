;; mewでhtmlを開けるようにする。
;; (require 'mew-w3m)
;; パスワードをキャッシュする。
(setq mew-use-cached-passwd t)
;; マスターパスワードを利用するようにする。
(setq mew-use-master-passwd t)

;; 検索エンジンの指定。
(setq mew-search-method 'est)           ; Hyper Estrainer

;; view-modeでの設定に合わせる。
(define-key mew-summary-mode-map (kbd "b") 'mew-summary-prev-page)

;; sslの証明書を保存するディレクトリの設定
;(setq mew-ssl-cert-directory "/opt/local/etc/stunnel/")
;; sslを利用するプログラムの設定
(setq mew-ssl-verify-version 0)
(setq mew-pop-delete t)
(setq mew-ssl-verify-level 0)

;;自動で振り分けるファイルは既読のみ
(setq mew-refile-auto-refile-skip-any-mark t)

;; メールのシグネチャは末尾につける。
(setq mew-signature-insert-last nil)

;; 未読のメールにはUマークが付くように
(setq mew-use-unread-mark t)
(setq mew-pop-auth 'pass)

;; 推測関数の設定
(setq mew-refile-guess-control
      '(mew-refile-guess-by-alist
        mew-refile-ctrl-throw
        mew-refile-guess-by-newsgroups
        mew-refile-guess-by-folder
        mew-refile-ctrl-throw
        mew-refile-guess-by-thread
        mew-refile-ctrl-throw
        mew-refile-guess-by-from-folder
        mew-refile-ctrl-throw
        mew-refile-guess-by-from
        mew-refile-ctrl-throw
        mew-refile-ctrl-auto-boundary
        mew-refile-guess-by-default))

; メールアドレスに対する設定
(setq mew-config-alist
      '(("gmail"
         ("name"        . "高橋 裕也")
         ("user"        . "derutakayu")
         ("mail-domain" . "gmail.com")
         ;; IMAPを利用するための設定
         ("proto" . "%")
         ("imap-server" . "imap.gmail.com")
         ("imap-ssl" . t)
         ("imap-ssl-port" . "993")
         ("imap-delete" . nil)
         ("imap-user" . "derutakayu@gmail.com")
         ("imap-auth" . t)
         ("imap-trash-folder" . "%[Gmail]/ゴミ箱")
         ("smtp-ssl"     . t)
         ("smtp-ssl-port" . "465")
         ("smtp-user"    . "derutakayu")
         ("smtp-server" . "smtp.gmail.com")
         ("prog-ssl" . "stunnel"))
        ("yahoo"
         ("pop-ssl"      . t)
         ("pop-ssl-port" . "995")
         ("name"        . "高橋 裕也")
         ("user"        . "derutakayu")
         ("mail-domain" . "yahoo.co.jp")
         ("pop-user"    . "derutakayu")
         ("pop-server"  . "pop.mail.yahoo.co.jp")
         ("smtp-ssl"     . t)
         ("pop-delete"  . t)
         ("smtp-ssl-port" . "465")
         ("smtp-user"    . "derutakayu")
         ("smtp-server" . "smtp.mail.yahoo.co.jp")
         ("prog-ssl" . "stunnel"))
        ("hotmail"
         ("pop-ssl"      . t)
         ("pop-ssl-port" . "995")
         ("name"        . "高橋 裕也")
         ("user"        . "derutakayu")
         ("mail-domain" . "hotmail.com")
         ("pop-user"    . "derutakayu@hotmail.com")
         ("pop-server"  . "pop3.live.com")
         ("smtp-ssl"     . t)
         ("pop-delete"  . nil)
         ("smtp-ssl-port" . "25")
         ("smtp-user"    . "derutakayu@hotmail.com")
         ("smtp-port" . "587")
         ("smtp-server" . "smtp.live.com")
         ("prog-ssl" . "stunnel"))))

;; メールの自動取得に対応させる。
(setq mew-auto-get t)
(setq mew-use-biff t)
(setq mew-use-biff-bell t)
(setq mew-biff-function 'mew-biff-bark)
(setq mew-biff-interval 5)
(setq visible-bell nil)

(setq frame-title-format
      '((multiple-frames "")
        mew-biff-string            ; メール数
        " %b " (buffer-file-name "[%f]")    ; バッファ名(ファイル名)
))
(setq icon-title-format 'frame-title-format)

;; メール取得後に spam filter をかける
(defun spam-filter () (interactive)
  (let* ((prog-name "bogo")
         (folder (mew-summary-folder-name))
         (dir (mew-expand-folder folder))
         msgs
         )
    (with-temp-buffer
      (mew-set-buffer-multibyte t)
      (cd dir)
      (call-process prog-name nil t nil "")

      (goto-char (point-min))
      (while (re-search-forward mew-regex-message-files2 nil t)
        (setq msgs (cons (mew-match-string 1) msgs))
        (forward-line)
        )
      )
    (setq msgs (mew-uniq-list msgs))
    (setq msgs (mapcar 'string-to-number msgs))
    (setq msgs (sort msgs '<))
    (setq msgs (mapcar 'number-to-string msgs))
    (mew-summary-pick-ls folder msgs)
    (mew-refile-set msgs "+newspam")
    (mew-mark-exec-refile folder msgs)
    )
  )

;; ローカルのフィルタに学習させる。
(setq mew-spam-prog "bogo")
(setq mew-spam-prog-args '("-s"))
(setq mew-ham-prog "bogo")
(setq mew-ham-prog-args '("-n"))
