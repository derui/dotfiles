function my_key_bindings
    for mode in insert default visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase

    bind -M insert -m default jj force-repaint
    bind -M default \cr __select_history
    bind -M insert \cr __select_history
    bind -M default \cs__select_ghq_cd
    bind -M insert \cs __select_ghq_cd
end
