let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIo7Zr2fnuJawO4FWqIzBHIILWTft9ZSiGGWy21VPPhi";
  users = [ user1 ];

  mkSecret = name: {
    inherit name;
    value = {
      publicKeys = users;
      armor = true;
    };
  };
in
builtins.listToAttrs (
  map mkSecret [
    "ssh-private-config.age"
    "github.age"
    "home.age"
    "server.age"
  ]
)
