# NixOS configuration

Declarative configuration for restoring this workstation. Personal data,
credentials, SSH keys, passwords, and application accounts are not included.

## Empty-disk recovery

Boot the NixOS installer in UEFI mode, connect to the network, and clone this
repository. Identify the replacement disk with:

```bash
lsblk -o NAME,SIZE,MODEL,SERIAL,TYPE,MOUNTPOINTS
ls -l /dev/disk/by-id/
```

Run the following after replacing every `<...>` placeholder. Supply a
pre-generated password hash from a private USB drive.

> **Warning:** this irreversibly erases the selected disk.

```bash
sudo nix --accept-flake-config run .#disko-install -- \
  --flake .#nixos \
  --disk main /dev/disk/by-id/<target-disk> \
  --write-efi-boot-entries \
  --option accept-flake-config true \
  --extra-files <password-hash-on-usb> /etc/nixos-secrets/user-password.hash \
  --system-config '{"users":{"users":{"<system-user>":{"hashedPasswordFile":"/etc/nixos-secrets/user-password.hash"}}}}'
```

After rebooting, clone the repository into its permanent location and point
`/etc/nixos` to that working copy.
