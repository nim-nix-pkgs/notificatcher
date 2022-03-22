{
  description = ''Small program to read freedesktop notifications and format them as strings'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-notificatcher-v0_2_0.flake = false;
  inputs.src-notificatcher-v0_2_0.ref   = "refs/tags/v0.2.0";
  inputs.src-notificatcher-v0_2_0.owner = "PMunch";
  inputs.src-notificatcher-v0_2_0.repo  = "notificatcher";
  inputs.src-notificatcher-v0_2_0.type  = "github";
  
  inputs."dbus".owner = "nim-nix-pkgs";
  inputs."dbus".ref   = "master";
  inputs."dbus".repo  = "dbus";
  inputs."dbus".dir   = "";
  inputs."dbus".type  = "github";
  inputs."dbus".inputs.nixpkgs.follows = "nixpkgs";
  inputs."dbus".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-notificatcher-v0_2_0"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-notificatcher-v0_2_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}