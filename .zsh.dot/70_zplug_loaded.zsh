# -*- mode:shell-script -*-
# scripts after loading zplug
eval "$(direnv hook zsh)"

# When opam is available, merge configurations generated from it.
# This command needs only login shell
if [[ -x $(which opam) ]]; then
    # $MANPATH is overwrited by opam config..., so it back up and restore.
    PREV_MANPATH=$MANPATH
    eval $(opam env)
    export MANPATH=$MANPATH:$PREV_MANPATH
fi
