{ lib, config, ... }:

let
  cfg = config.services.el-monitorro;
in
{
  options.services.el-monitorro = {
    enable = lib.mkEnableOption "El Monitorro's general configuration";
  };

  config = lib.mkIf cfg.enable {

  };
}
