# https://github.com/albertz/dotfiles/blob/master/.config/fish/config.fish
egrep "^export " ~/.profile | while read e
    set var (echo $e | sed -E "s/^export ([0-9A-Z_]+)=(.*)\$/\1/")
    set value (echo $e | sed -E "s/^export ([0-9A-Z_]+)=(.*)\$/\2/")

    # remove surrounding quotes if existing
    set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

    if test $var = "PATH" -o $var = "MANPATH"
        # replace ":" by spaces. this is how PATH looks for Fish
        set value (echo $value | sed -E "s/:/ /g")

        # use eval because we need to expand the value
        eval set -xg $var $value

        continue
    end

    # evaluate variables. we can use eval because we most likely just used "$var"
    set value (eval echo $value)

    #echo "set -xg '$var' '$value' (via '$e')"
    set -xg $var $value
end

# change location of packages installed by fisher
set -g fisher_path ~/.config/fish/fisher-pkg

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    builtin source $file ^ /dev/null
end

# disable virtualenv's original prompt
set -g VIRTUAL_ENV_DISABLE_PROMPT "1"
# enable virtualenv if exists
if test -f ~/.virtualenv/bin/activate.fish
    . ~/.virtualenv/bin/activate.fish
end

# Enable direnv if exists
if test -x (which direnv)
    direnv hook fish | source
end

# Load opam config if it exists
if test -f ~/.opam/opam-init/init.fish
    builtin source ~/.opam/opam-init/init.fish
end

set -g fish_key_bindings my_key_bindings

# default fzf option
set -gx FZF_DEFAULT_OPTS "--no-sort --reverse --ansi --border --height 50%"

set -l _emacsclient (which emacsclient)
if test -x "$_emacsclient"
    set -gx EDITOR "emacsclient"
else
    set -gx EDITOR "vim"
end

# set aliases
set -l _eza (which eza)
if test -x "$_eza"
    alias ls='eza --icons'
end

alias g=git

if test -f ~/.secrets/fish
    builtin source ~/.secrets/fish
end

if test -d ~/.asdf
    source ~/.asdf/asdf.fish
end

if test -f ~/bin/starship
    ~/bin/starship init fish | source
end

if ! type -q fisher
    echo "You should install fisher after first booting fish."
    echo "execute in fish: ~/.config/fish/fisher-install.fish"
end

if test -d ~/.volta/
    set -gx VOLTA_HOME "$HOME/.volta"
    set -gx PATH "$VOLTA_HOME/bin" $PATH
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
