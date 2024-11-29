{ lib, config, ... }:

let
  cfg = config.services.el-monitorro;
in
{
  options.services.el-monitorro = {
    enable = lib.mkEnableOption "El Monitorro's service";
    database-url = lib.mkOption {
      example = "postgres://username:password@localhost/el_monitorro";
      description = "DB Postgres url. If let unset, a local DB will be setup.";
      type = lib.types.str;
    };
    telegram-token = lib.mkOption {
      example = "6666618370:AAGx5YhNQvUG4eUcQXN-OB_a09ZzYl6aaaa";
      description = "Telegram token to be used. This is required.";
      type = lib.types.str;
    };
    database-pool-size = lib.mkOption {
      default = 5;
      example = 10;
      description = "The maximum number of connections for global connection pool (global per binary except if {option}`services.el-monitorro.all-binaries` is set to true).";
      type = lib.types.int;
    };
    all-binaries = lib.mkOption {
      default = false;
      example = true;
      description = "If true, all services will be started in the main binary.";
      type = lib.types.bool;
    };
    telegram-bot-handle = lib.mkOption {
      example = "el_monitorro_bot";
      description = "This value is used during parsing of commands. If you set autocompletion menu for your bot, the bot will understand commands like `/subscribe@<handle>` along with just `/subscribe`.";
      type = lib.types.str;
    };
    subscription-limit = lib.mkOption {
      default = 20;
      example = 40;
      description = ""; # TODO
      type = lib.types.int;
    };
    filter-limit = lib.mkOption {
      default = 20;
      example = 40;
      description = "The maximum number of filter words that can be set per subscription or as the global filter.";
      type = lib.types.str;
    };
    sync-interval-seconds = lib.mkOption {
      default = 60;
      example = 40;
      description = "The bot tries to sync feeds every `SYNC_INTERVAL_SECONDS` seconds.";
      type = lib.types.int;
    };
    sync-workers-number = lib.mkOption {
      default = 1;
      example = 4;
      description = "The number of workers to sync feeds.";
      type = lib.types.int;
    };
    deliver-interval-seconds = lib.mkOption {
      default = 60;
      example = 120;
      description = "The bot tries to deliver new feed items every `DELIVER_INTERVAL_SECONDS` seconds.";
      type = lib.types.int;
    };
    deliver-workers-number = lib.mkOption {
      default = 1;
      example = 4;
      description = "The number of workers to deliver updates.";
      type = lib.types.int;
    };
    clean-interval-seconds = lib.mkOption {
      default = 3600;
      example = 1800;
      description = "The bot cleans old feed items and feeds without subscriptions every `CLEAN_INTERVAL_SECONDS` seconds.";
      type = lib.types.int;
    };
    clean-workers-numbers = lib.mkOption {
      default = 1;
      example = 4;
      description = "The number of workers to remove old data.";
      type = lib.types.int;
    };
    owner-telegram-id = lib.mkOption {
      example = "your_id_here"; # TODO: does this need the @?
      description = "If this value is set, the bot will process commands only from the specified user id.";
      type = lib.types.str;
    };
    request-timeout = lib.mkOption {
      default = 5;
      example = 10;
      description = "Timeout in seconds for feed syncing requests.";
      type = lib.types.int;
    };
    admin-telegram-id = lib.mkOption {
      example = "your_admin_id_here"; # TODO: same issue as above
      description = "If this value is set, /info command with stats is available for the specified account.";
      type = lib.types.str;
    };
    extra-config = lib.mkOption {
      default = { };
      example = {
        SOME_CONFIG_VAR1 = "some value";
        SOME_CONFIG_VAR2 = "some other value";
      };
      description = "Extra configuration for El Monitorro, in the form of environment variables.";
      type =
        with lib.types;
        attrsOf (oneOf [
          int
          str
          path
        ]);
    };
  };

  config = lib.mkIf cfg.enable {

  };
}
