# coyyngx78's NixOS configuration
This is my personal NixOS configuration that I use on my Framework 16 (7040 series).
## Installing
In order to use my configuration, first git clone this repository to wherever you want. Delete redundant files like the license and the readme. Clone hardware-configuration.nix from /etc/nixos into this folder. Next, you MUST tweak many settings. These include: the hostname, users, file paths that involve the nixos directory you chose, nixos-hardware stuff, background etc. The files that would be linked to places in .config are under the dots folder. Now, build the system (sudo nixos-rebuild switch --flake /the/directory/you/chose). As one of the two non-reproducible parts of the system, manually enable waybar.service with systemctl --user enable --now waybar.service. If you caught everything, congratulations!
## Details
NixOS version: Latest stable (currently 26.05) with flakes  
Kernel: Latest stable  
Desktop elements: sway + rofi + waybar  
Terminals: kitty (main), foot  
Shell: fish (only in kitty), bash  
Browsers: Librewolf (main), Tor, Firefox  
Editor: Neovim + Lazyvim (lazyvim-nix by pfassina)  
File Manager: Thunar  
Font: Maple Mono Nerd Font (cv01 on)  
Games: SuperTuxKart, Minecraft via Prism Launcher  
Apps: btop++, Freetube, KeePassXC, VLC, Ristretto  
## Custom Sway Binds
Super+Y opens clipboard history  
Super+P opens power menu  
Super+G opens Librewolf  
Super+T opens Thunar  
All other binds are default
