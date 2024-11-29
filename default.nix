{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  toml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
in
pkgs.rustPlatform.buildRustPackage {
  pname = toml.package.name;
  version = toml.package.version;
  cargoLock.lockFile = ./Cargo.lock;
  doCheck = false;
  src = pkgs.lib.cleanSource ./.;
  nativeBuildInputs = with pkgs; [
    pkg-config
  ];
  buildInputs = with pkgs; [
    openssl
    postgresql.lib
  ];
}
