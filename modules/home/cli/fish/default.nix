{
  osConfig,
  config,
  lib,
  ...
}:
{

  config = lib.mkIf osConfig.cfg.fish.enable {
    programs.fish = {
      enable = true;
      shellAliases = {
        ls = lib.mkIf config.cfg.cli.eza.enable "eza";
        cat = lib.mkIf config.cfg.cli.bat.enable "bat";
        "..." = "cd ../..";
      };
      interactiveShellInit =
        "set fish_greeting\n" + lib.optionalString config.programs.helix.enable "set EDITOR hx\n";
    };
  };
}
