set -gx XDG_CONFIG_HOME "$HOME/.config"

/opt/homebrew/bin/brew shellenv | source

if type -q starship
  set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
  starship init fish | source
end

if type -q thefuck
  thefuck --alias | source
end

if type -q zoxide
  zoxide init fish --cmd cd | source
end

if type -q fnm
  fnm env --use-on-cd | source
end
