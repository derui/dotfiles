
if test -e $HOME/.nix-profile/etc/profile.d/nix.fish
    . $HOME/.nix-profile/etc/profile.d/nix.fish

    # nixos用の設定を追加しておく
    set -xg CLAUDE_CODE_EXECUTABLE (which claude)
end
