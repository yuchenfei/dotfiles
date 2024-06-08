abbr reload 'source ~/.config/fish/config.fish'

if type -q chezmoi
  abbr c 'chezmoi'
  abbr ca 'chezmoi apply'
  abbr cu 'chezmoi update'
  abbr ce 'chezmoi edit'
  abbr cs 'chezmoi status'
  abbr cc 'chezmoi cd'
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

abbr lg lazygit
abbr ps procs
abbr du ncdu

