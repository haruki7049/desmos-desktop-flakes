{
  description = "Desmos Desktop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, systems }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        appimageTools = pkgs.appimageTools;
        fetchurl = pkgs.fetchurl;
        desmos-desktop = appimageTools.wrapType2 {
          pname = "desmos-desktop";
          version = "1.0.0";

          src = fetchurl {
            url = "https://github.com/DingShizhe/Desmos-Desktop/releases/download/v1.0.0/desmos-1.0.0-x86_64.AppImage";
            hash = "sha256-JAqtv/Y0ydlPFN8AdhpZbqc/1gpqZ2EkYucNzDYQ4Sw=";
          };

          extraPkgs = pkgs: with pkgs; [ ];
        };
      in
      {
        apps.desmos-desktop = flake-utils.lib.mkApp {
          drv = desmos-desktop;
        };
        packages = {
          inherit desmos-desktop;
          default = desmos-desktop;
        };
      });
}
