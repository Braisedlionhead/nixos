# Clash Verge configuration for the hd work machine.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nftables
  ];
  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    autoStart = true;

    # 你的版本支持时保留；如果重建提示选项不存在就删除
    tunMode = true;
  };

  systemd.services.clash-verge.serviceConfig.CapabilityBoundingSet = [
    "CAP_CHOWN"
    "CAP_DAC_OVERRIDE"
    "CAP_SETGID"
    "CAP_SETUID"
    "CAP_NET_ADMIN"
    "CAP_NET_RAW"
    "CAP_NET_BIND_SERVICE"
    "CAP_SYS_ADMIN"
    "CAP_MKNOD"
  ];

  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;

    trustedInterfaces = [
      "Mihomo"
    ];

    extraReversePathFilterRules = ''
      iifname { "Mihomo" } accept comment "Allow Clash Verge TUN"
    '';
  };
}
