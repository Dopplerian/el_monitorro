{
  description = "El Monitorro's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      nixosModules.default = import ./nixosModules;
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages.default = pkgs.callPackage ./default.nix { };
        devShells.default = pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.default ];
          packages = with pkgs; [
            diesel-cli
            gnumake
            docker # this still requires you to be running the docker daemon
            rust-analyzer
            rustfmt
          ];
        };
      }
    );
}
