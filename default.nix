{
  pkgs ? import <nixpkgs> {
    overlays = [
      (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
    ];
  },
  ...
}:
let
  toml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
  rust = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
  rustPlatform = pkgs.makeRustPlatform {
    cargo = rust;
    rustc = rust;
  };
in
rustPlatform.buildRustPackage {
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
