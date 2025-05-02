{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, astal }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      name = "xtreme_shell";
      src = ./.;

      nativeBuildInputs = with pkgs; [
        meson
        ninja
        gobject-introspection
        wrapGAppsHook4
      ];

      buildInputs = with astal.packages.${system}; [
        io
        astal4
        battery
        hyprland
        wp
        mpris
        tray
        bluetooth
        apps
        notifd
      ];
    };
  };
}
