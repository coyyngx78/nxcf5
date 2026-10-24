{
  pkgs,
  inputs,
  ...
}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      grub.enable = false;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl."kernel.sysrq" = 1;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  fileSystems = {
    "/".options = ["compress=zstd" "noatime"];
    "/home".options = ["compress=zstd" "noatime"];
    "/nix".options = ["compress=zstd" "noatime"];
  };

  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "snowbook";
  networking.networkmanager.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    users.codx78 = ./home.nix;
    backupFileExtension = "hm-backup";
  };

  users.users."codx78" = {
    isNormalUser = true;
    description = "codx78";
    extraGroups = ["networkmanager" "wheel" "video" "audio"];
  };

  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      curl
      zip
      unzip
      psmisc
      file
      gcc
      clang
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };

  programs = {
    firefox.enable = true;

    git = {
      enable = true;
      config = {
        user = {
          name = "coyyngx78";
          email = "coyyng846@gmail.com";
        };
      };
    };

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        sway = {
          prettyName = "SwayWM";
          comment = "Sway and UWSM";
          binPath = "/run/current-system/sw/bin/sway";
        };
      };
    };

    fish.enable = true;
    thunar.enable = true;
  };

  services = {
    flatpak.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    displayManager.gdm.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Maple Mono NF"];
        sansSerif = ["Maple Mono NF"];
        serif = ["Maple Mono NF"];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <match target="font">
            <test name="family" compare="contains">
              <string>Maple Mono</string>
            </test>
            <edit name="fontfeatures" mode="append">
              <string>cv01 on</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };

    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      maple-mono.NF
    ];
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
  services.ipp-usb.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security = {
    pam.services = {
      login.fprintAuth = false;
      swaylock.fprintAuth = false;
    };
    rtkit.enable = true;
    polkit.enable = true;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="backlight", ENV{ID_BACKLIGHT_CLAMP}="0"
  '';

  nix.settings.auto-optimise-store = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
