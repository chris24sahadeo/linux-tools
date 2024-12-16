# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# TODO: figure out how to disable sleep / suspend OR how to wake up remotely from those states!

 # TODO: move these packages and any other associated useful dev tools to a different file so they can be used in a docker file for setting up dev tools 
 # see: https://chatgpt.com/c/675b1edf-eb7c-8005-bc1e-1379d7554aa5
{
  # List packages installed in system profile. To search, run:f
  # $ nix search wget
  environment.systemPackages = with pkgs; [
# lunarvim # FIXME: neovim alias error on stable.
# vimPlugins.LazyVim
tree    
vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    python3
#    nvtop # TODO: move to nvidia config file.
    google-chrome
    vscode
#    warp-terminal
    docker
    whatsapp-for-linux
    btop
    git
    curl
    slack
    xorg.xhost
    lazydocker 
    tmux
    github-desktop
    gh
    copyq
    nixos-generators
    fzf
    eza
    glances
    zoxide
    starship
    ripgrep
    fd
    bat
    tldr
    lazygit
    delta
    jq
    lshw
    zoom-us
  ];

programs.starship = {
  enable = true;
};

programs.neovim = {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  configure = {
    packages.myVimPackage = with pkgs.vimPlugins; {
      start = [ ctrlp 
       nvim-tree-lua
      ];
    };
    };
};

services.tailscale.enable = true;

# FIXME: This doesn't work, and even if it did, it should be part of "home manager" config (TODO).
 programs.git.config.user = {
  name = "Chris Sahadeo";
  email = "chris@virtanatech.com";
};

# TODO: move to a nvidia config file.
  # START: Nvidia...
  # Load nvidia driver for Xorg and Wayland
#   services.xserver.videoDrivers = ["nvidia"];
# 
#   hardware.nvidia = {
# 
#     # Modesetting is required.
#     modesetting.enable = true;
# 
#     # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
#     # Enable this if you have graphical corruption issues or application crashes after waking
#     # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
#     # of just the bare essentials.
#     powerManagement.enable = false;
# 
#     # Fine-grained power management. Turns off GPU when not in use.
#     # Experimental and only works on modern Nvidia GPUs (Turing or newer).
#     powerManagement.finegrained = false;
# 
#     # Use the NVidia open source kernel module (not to be confused with the
#     # independent third-party "nouveau" open source driver).
#     # Support is limited to the Turing and later architectures. Full list of 
#     # supported GPUs is at: 
#     # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
#     # Only available from driver 515.43.04+
#     # Currently alpha-quality/buggy, so false is currently the recommended setting.
#     open = false;
# 
#     # Enable the Nvidia settings menu,
# 	# accessible via `nvidia-settings`.
#     nvidiaSettings = true;
# 
#     # Optionally, you may need to select the appropriate driver version for your specific GPU.
#     package = config.boot.kernelPackages.nvidiaPackages.stable;
#   };
 

  # END: Nvidia...
  
#  programs.bash = {
 #   promptInit = ''
 #     PS1='\w $ '
 #   '';
 # };

  environment.shellAliases = {
    ll = "ls -l";
    # vi = "nvim";

    # docker.
    dcu = "docker compose up";
    dcd = "docker compose down";
    ld = "lazydocker";

    # nixos.
    edit = "sudo vi /etc/nixos/configuration.nix";
    switch = "sudo nixos-rebuild switch";
    ntest = "sudo nixos-rebuild test";

    # git.
    lg = "lazygit";
    g = "git";
    gs = "git status";
    ga = "git add";
    gaa = "git add -A";
    gcm = "git commit --message";
    gcam = "git add -A && git commit --message";
    gpl = "git pull";
    gph = "git push";
  };

  # FIXME: this just doesn't work.
  environment.variables = {
    #EDITOR = "nvim";
    #visual = "code";
  };

  environment.interactiveShellInit = ''
    # Your bash settings here
    eval "$(zoxide init bash)"
  '';

  nixpkgs.config.allowUnfree = true; 
  virtualisation.docker.enable = true;
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

# TODO: remove once other PCs are reformatted to remove disk level encryption
#    boot.initrd.luks.devices."luks-b8b53034-d87d-44f4-a05e-81181219b9d7".device = "/dev/disk/by-uuid/b8b53034-d87d-44f4-a05e-81181219b9d7"; # the-beast

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Port_of_Spain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable=true;
    # xkbOptions = "caps:escape";  # This specific option swaps Caps Lock with Escape

  };

  # If you're using Wayland (GNOME or KDE), you might also want:
  # environment.sessionVariables = {
  #  NIXOS_OZONE_WL = "1";  # Helps with Wayland compatibility
  # };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chris = {
    isNormalUser = true;
    description = "chris";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
#  programs.firefox.enable = true;

  programs.steam.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?


}
