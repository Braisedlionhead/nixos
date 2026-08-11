# Noctalia system integration for the hd work machine.
{ ... }:

{
  # Noctalia uses these system services for its network, Bluetooth, battery,
  # and power-profile integrations. NetworkManager and PipeWire are enabled in
  # the hd host configuration already.
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
