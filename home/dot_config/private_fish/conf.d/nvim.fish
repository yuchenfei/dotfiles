alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

set -gx NVIM_APPNAME AstroNvim

# nvim
if type -q nvim
  abbr v 'nvim'
  abbr vi 'nvim'
  abbr vim 'nvim'
  abbr sv 'sudo nvim'
  abbr svi 'sudo nvim'
  abbr svim 'sudo nvim'
end
