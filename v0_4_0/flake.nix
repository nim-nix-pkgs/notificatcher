{
  description = ''Small program to read freedesktop notifications and format them as strings'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-notificatcher-v0_4_0.flake = false;
  inputs.src-notificatcher-v0_4_0.ref   = "refs/tags/v0.4.0";
  inputs.src-notificatcher-v0_4_0.owner = "PMunch";
  inputs.src-notificatcher-v0_4_0.repo  = "notificatcher";
  inputs.src-notificatcher-v0_4_0.type  = "github";
  
  inputs."dbus".owner = "nim-nix-pkgs";
  inputs."dbus".ref   = "master";
  inputs."dbus".repo  = "dbus";
  inputs."dbus".dir   = "master";
  inputs."dbus".type  = "github";
  inputs."dbus".inputs.nixpkgs.follows = "nixpkgs";
  inputs."dbus".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/pmunch/docopt.nim".owner = "nim-nix-pkgs";
  inputs."github.com/pmunch/docopt.nim".ref   = "master";
  inputs."github.com/pmunch/docopt.nim".repo  = "github.com/pmunch/docopt.nim";
  inputs."github.com/pmunch/docopt.nim".dir   = "";
  inputs."github.com/pmunch/docopt.nim".type  = "github";
  inputs."github.com/pmunch/docopt.nim".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/pmunch/docopt.nim".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."nimpng".owner = "nim-nix-pkgs";
  inputs."nimpng".ref   = "master";
  inputs."nimpng".repo  = "nimpng";
  inputs."nimpng".dir   = "v0_3_1";
  inputs."nimpng".type  = "github";
  inputs."nimpng".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimpng".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-notificatcher-v0_4_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-notificatcher-v0_4_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}