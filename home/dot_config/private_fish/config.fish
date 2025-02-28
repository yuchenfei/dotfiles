set -g fish_greeting
set -gx XDG_CONFIG_HOME "$HOME/.config"

set -l os (uname)
if test $os = Darwin
    /opt/homebrew/bin/brew shellenv | source
else if test $os = Linux
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end

fish_add_path ~/.cargo/bin
fish_add_path ~/miniconda3/bin
fish_add_path ~/.rye/shims
fish_add_path ~/.orbstack/bin
fish_add_path ~/.lmstudio/bin

if type -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else if type -q vim
    set -gx EDITOR vim
    set -gx VISUAL vim
else
    set -gx EDITOR vi
    set -gx VISUAL vi
end

if status is-interactive
    if test $os = Darwin
        if status is-login
            ssh-add -l >/dev/null || ssh-add --apple-load-keychain &>/dev/null
        end
    end

    if type -q starship
        set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
        starship init fish | source
    end

    if type -q zoxide
        zoxide init fish | source
    end

    if type -q thefuck
        thefuck --alias | source
    end

    if type -q fnm
        fnm env --use-on-cd | source
    end

    if type -q fastfetch
        fastfetch
    end

    fzf_configure_bindings --directory=\cf --variables=\e\cv
end
