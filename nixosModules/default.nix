{ lib, config, ... }:

let
  cfg = config.elMonitorro;
in
{
  options.elMonitorro = {
    enable = lib.mkEnableOption "El Monitorro's general configuration";
  };

  config = lib.mkIf cfg.enable {

  };
}
