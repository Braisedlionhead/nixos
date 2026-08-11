# Maintenance policy for the hd work machine.
{ ... }:

{
  # 定期删除旧系统代以及无引用的 Nix Store 内容。
  nix.gc = {
    automatic = true;

    # 每周日凌晨 3 点运行。
    dates = "Wed 08:30";

    # 保留最近 14 天的系统代。
    options = "--delete-older-than 14d";

    # 关机错过时间后，在下次开机时补执行。
    persistent = true;
  };

  # 定期对 Nix Store 中内容相同的文件进行硬链接去重。
  nix.optimise = {
    automatic = true;
    dates = [ "Wed 08:40" ];
  };
}
