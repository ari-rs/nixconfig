{
  inputs,
  username,
  ...
}:
{
  imports = [
    ./disks.nix
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
