curl -sL https://git.io/fisher | source

cat ~/.config/fish/fish_plugins | while read p
    fisher install $p
end
