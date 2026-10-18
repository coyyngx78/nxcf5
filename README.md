# coyyngx78's NixOS configuration
This is my personal NixOS configuration that I use on my Framework 16 (7040 series) laptop.
## Installing
In order to use my configuration, first git clone this repository to wherever you want. Delete redundant files like the license and the readme. Then, tweak settings such as the hostname and users, and also remove my nixos-hardware stuff. Make sure you have git. Finally, rebuild the system (sudo nixos-rebuild switch --flake /the/directory/you/chose).
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
Games: SuperTuxKart, Minecraft via Prism Launcher, considering minesweeper  
Apps installed: Freetube, KeePassXC, and more  
(Not a comprehensive list)
## Custom Sway Binds
Super+Y opens clipboard history  
Super+P opens power menu  
Super+G opens Librewolf  
Super+T opens Thunar  
