# coyyngx78's NixOS configuration
This is my NixOS configuration. In order to use, first git clone this repository to ~/nixos-conf and tweak some settings, most notably the hostname. Remove hardware-configuration.nix, and copy YOUR hardware-configuration.nix over from /etc/nixos. Then run 'sudo nixos-rebuild switch --flake ~/nixos-conf#snowbook'. 
