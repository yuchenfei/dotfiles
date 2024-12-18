alias vl="NVIM_APPNAME=nvim-lazyvim nvim"
alias va="NVIM_APPNAME=nvim-astronvim nvim"
alias vc="NVIM_APPNAME=nvim-custom nvim"

# default nvim
# set -gx NVIM_APPNAME AstroNvim

# nvim
if type -q nvim
    abbr v nvim
    abbr vi nvim
    abbr vim nvim
    abbr sv 'sudo nvim'
    abbr svi 'sudo nvim'
    abbr svim 'sudo nvim'
end
