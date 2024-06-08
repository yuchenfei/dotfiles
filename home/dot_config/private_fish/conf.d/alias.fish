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

if type -q btm
  alias top="btm --enable_cache_memory --network_use_binary_prefix --network_use_bytes -b"
  alias b="btm --enable_cache_memory --network_use_binary_prefix --network_use_bytes --battery"
end
