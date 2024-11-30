abbr reload 'source ~/.config/fish/config.fish'

if type -q chezmoi
  abbr cz 'chezmoi'
  abbr cza 'chezmoi apply'
  abbr czu 'chezmoi update'
  abbr cze 'chezmoi edit'
  abbr czx 'chezmoi execute-template <'
  abbr czs 'chezmoi status'
  abbr czc 'chezmoi cd'
end

if type -q docker-compose
  abbr dc 'docker-compose'
  abbr dcu 'docker-compose up'
  abbr dcud 'docker-compose up -d'
  abbr dcd 'docker-compose down'
  abbr dcl 'docker-compose logs'
  abbr dclf 'docker-compose logs -f'
  abbr dcp 'docker-compose pull'
end

if type -q eza
  alias ls="eza --icons --no-quotes --group-directories-first"
  alias lsa="ls -a"
  alias l="ls -lb --colour-scale --time-style=relative --git"
  alias ll="l -aG"
  alias ld="l -D"
  alias lf="l -f"
  alias lh="l -d .*"
  alias la="ls -lba --smart-group --colour-scale --time-style=iso --git"
  alias lm="la --sort=modified"
  alias lt="la --tree --level=2 --git-ignore"
end

if type -q fastfetch; abbr ff fastfetch; end

if type -q lazygit; abbr lg lazygit; end

alias get_idf=". $HOME/documents/Code/Github/esp-idf/export.fish"

