{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  home = {
    username = "codx78";
    homeDirectory = "/home/codx78";
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;

  imports = [ inputs.lazyvim.homeManagerModules.default ];

  home.packages = with pkgs; [
    # CLI tools
    gnumake
    fzf
    fd
    tree-sitter
    ripgrep
    python3
    rustc
    cargo
    lua
    unstable.fastfetch
    btop
    nodejs

    # GUI Apps
    vlc
    librewolf
    tor-browser
    prismlauncher
    unstable.freetube
    foot
    ristretto
    supertuxkart
    keepassxc

    # Misc
    pavucontrol
    pulseaudio
    brightnessctl
    lxqt.lxqt-policykit
    grim
    swaybg
    networkmanagerapplet
    wl-clipboard
    sway-audio-idle-inhibit
    rofi
    waybar
  ];

  programs = {
    fish = {
      enable = true;
      shellAliases = {
        clean = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d";
        nrsf = "sudo nixos-rebuild switch --flake ~/.nixos-conf#snowbook";
        sec = "nvim ~/.nixos-conf/configuration.nix";
        seh = "nvim ~/.nixos-conf/home.nix";
      };
      interactiveShellInit = ''
        set fish_greeting ""
      '';
    };

    kitty = {
      enable = true;
      font = {
        name = "Maple Mono NF";
        package = pkgs.maple-mono.NF;
        size = 11;
      };
      themeFile = "OneDark-Pro";
      settings = {
        confirm_os_window_close = 0;
        shell = "fish";
      };
      shellIntegration.enableFishIntegration = true;
      package = unstable.kitty;
    };

    lazyvim = {
      enable = true;
      config = {
        options = ''
          vim.g.autoformat = false;
        '';
        autocmds = ''
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "h" },
            callback = function()
              vim.opt_local.tabstop = 4
              vim.opt_local.softtabstop = 4
              vim.opt_local.shiftwidth = 4
            end,
          })
        '';
      };

      plugins = {
        noautopairs = ''
          return {
            { "nvim-mini/mini.pairs", enabled = false },
          }   
        '';
      };

      extras = {
        editor.telescope.enable = true;

        lang = {
          nix = {
            enable = true;
            config = ''
              return {
                {
                  "neovim/nvim-lspconfig",
                  opts = {
                    servers = {
                      nil_ls = { enabled = false },
                      nixd = {},
                    },
                  },
                },
                {
                  "stevearc/conform.nvim",
                  opts = {
                    formatters_by_ft = {
                      nix = { "alejandra" },
                    },
                  },
                },
              }
            '';
          };
          clangd = {
            enable = true;
            installDependencies = true;
          };
        };
      };
      extraPackages = with pkgs; [
        alejandra
        nixd
        statix
      ];
    };
  };

  services = {
    mako = {
      enable = true;
      settings = {
        default-timeout = 5000;
        ignore-timeout = true;
      };
    };
    cliphist = {
      enable = true;
      allowImages = true;
    };
  };

  home.file = {
    ".config/sway/config".source = ./dots/sway/config;
    ".config/waybar/config.jsonc".source = ./dots/waybar/config;
    ".config/waybar/style.css".source = ./dots/waybar/style.css;
    ".config/fastfetch/config.jsonc".source = ./dots/fastfetch/config.jsonc;
    ".config/rofi/config.rasi".source = ./dots/rofi/config.rasi;
  };
}
