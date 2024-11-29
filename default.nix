{
  pkgs ? import <nixpkgs> { },
  lib,
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

  meta = {
    description = "El Monitorro is an RSS, Atom and JSON feed reader as a Telegram bot.";
    homepage = "https://github.com/ayrat555/el_monitorro";
    license = lib.licenses.mit;
    mainProgram = "el_monitorro";
  };
}
