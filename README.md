# coyyngx78's NixOS configuration
This is my NixOS configuration that I use on my Framework 16 (7040 series) laptop.
## Installing
In order to use, first git clone this repository to wherever you want. Then, tweak some settings such as the hostname and the users, and remove my nixos-hardware stuff. If it is a fresh install, make sure you have git. Finally, rebuild the system (remember to use --flake).
## Details
NixOS version: Latest stable (currently 26.05) with flakes  
Kernel: Latest stable  
Desktop: Sway + wofi + waybar  
Terminal: Kitty  
Shell: fish  
Browsers: Firefox, Librewolf, Tor  
Editor: Neovim + Lazyvim (lazyvim-nix on github)  
File Manager: Thunar  
Font: Maple Mono Nerd Font (cv01)  
Apps installed: Freetube, Prism Launcher, KeePassXC, STK, + more  
(Not a comprehensive list)
## Custom Sway Binds
Super+Y opens clipboard history
Super+P opens power menu
Super+G opens Librewolf
Super+T opens Thunar
