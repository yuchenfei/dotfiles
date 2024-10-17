#!/opt/homebrew/bin/fish

if type -q ya
  set_color green
  echo ">>>>> Setup Yazi <<<<<"
  set_color normal

  ya pack -i
end
