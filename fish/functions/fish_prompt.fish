function fish_prompt
	if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    set_color yellow
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color magenta
    echo -n (prompt_hostname)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    # Line 2
    echo
    if test $VIRTUAL_ENV
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end
    printf '↪ '
    set_color normal
end

# enable powerline if extsts
if test -x (which powerline)
    set _powerline_repository_root (pip show powerline-status | egrep "^Location: " | sed -e 's/Location: \+//')
    set fish_function_path $fish_function_path "$_powerline_repository_root/powerline/bindings/fish"
    powerline-setup
    if test (pgrep powerline | wc -l) -eq 0
        powerline-daemon -q
    end
else
    echo "Powerline not found"
end
