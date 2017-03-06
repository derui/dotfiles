# -*- mode:shell-script -*-

zplug "~/.zsh/modules", \
    from:local, \
    defer:1, \
    use:"*.(sh|zsh)"

zplug "~/.zsh", \
    from:local, \
    defer:2, \
    use:"<->_*.zsh"

# install zsh plugins
zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-syntax-highlighting"

zplug "zsh-users/zsh-completions"

zplug "direnv/direnv", as:command, use:direnv, hook-build:"make"

zplug "b4b4r07/enhancd", use:init.sh
