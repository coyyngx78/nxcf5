{
  pkgs,
  inputs,
  lib,
  ...
}: let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  home = {
    username = "codx78";
    homeDirectory = "/home/codx78";
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;

  imports = [inputs.lazyvim.homeManagerModules.default];

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
    unstable.fetch
    btop
    nodejs

    # GUI Apps
    vlc
    # inputs.zen-browser.packages."${pkgs.system}".default
    librewolf
    tor-browser
    prismlauncher
    unstable.freetube
    kitty
    foot
    ristretto
    supertuxkart

    # Misc
    pavucontrol
    pulseaudio
    brightnessctl
    lxqt.lxqt-policykit
    grim
    swaybg
    networkmanagerapplet
    wl-clipboard
    zsh-powerlevel10k
  ];

  programs = {
    wofi = {
      enable = true;
      settings = {
        mode = "drun";
        insensitive = true;
        matching = "fuzzy";
        allow_images = true;
        parse_search = true;
        width = "30%";
      };
    };
    waybar.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 500;

      shellAliases = {
        clean = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d";
        nrsf = "sudo nixos-rebuild switch --flake /home/codx78/nixos-conf#snowbook";
        sec = "nvim ~/nixos-conf/configuration.nix";
        seh = "nvim ~/nixos-conf/home.nix";
      };

      initContent = lib.mkMerge [
        (lib.mkBefore ''
          if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi
        '')

        ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

          typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

          setopt CORRECT
        ''
      ];
    };
    lazyvim = {
      enable = true;
      ignoreBuildNotifications = true;

      config = {
        options = ''
          vim.g.autoformat = false;

          -- Let .c and .h files get 4 space indentation
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

      extras.lang = {
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
  };
}
