# -*- mode:shell-script -*-

zplug "~/.zsh/modules", \
    from:local, \
    nice:1, \
    use:"*.(sh|zsh)"

zplug "~/.zsh", \
    from:local, \
    nice:2, \
    use:"<->_*.zsh"

# install zsh plugins
zplug "zsh-users/zsh-history-substring-search"

zplug "b4b4r07/enhancd", use:init.sh

zplug "zsh-users/zsh-syntax-highlighting"

zplug "zsh-users/zsh-completions"
