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

alias get_idf=". $HOME/documents/Code/Github/esp-idf/export.fish"

