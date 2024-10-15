function my_key_bindings
    for mode in insert default visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase

    bind -M insert -m default jj force-repaint
    bind -M default \cr 'history save; history merge; __select_history'
    bind -M insert \cr 'history save; history merge; __select_history'
    bind -M default \cs__select_ghq_cd
    bind -M insert \cs __select_ghq_cd
    bind -M insert \c_ __integrated_completer
    bind -M default \cgs __git_change_branch
    bind -M insert \cgs __git_change_branch
    bind -M default \cgn __git_new_branch
    bind -M insert \cgn __git_new_branch
end
