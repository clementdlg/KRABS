# check privileges
if [[ $EUID -ne 0 ]]; then
    echo "Error: Run this script with root privileges"
    exit 1
fi

echo "Installing system packages"

packages=(
    # desktop
    "@xfce-desktop-environment"
    "awesome"
    "picom"
    "lightdm"
    "lightdm-gtk"
    "rofi"

    # dev
    "neovim"
    "vim"
    "git"
    "tmux"
    "distrobox"
    "podman"
    "cargo"

    # cli utils
    "htop"
    "btop"
    "wget"
    "unzip"
    "tar"
    "ripgrep"
    "eza"
    "bat"
    "fzf"

    # apps
    "alacritty"
    "firefox"
    "flatpak"
    "syncthing"
    "vlc"
    "timeshift"
    "flameshot"
    "thunar"
    "flameshot"
    "NetworkManager"
    "network-manager-applet"
    "blueman"
    "wireshark"

    # virtu
    "virt-manager"
    "libvirt-client-qemu"
    "libvirt-daemon-qemu"
    "qemu-kvm"
    "virt-viewer"

    # other
    "default-fonts-core-emoji"
    "epapirus-icon-theme"
    "xfce4-genmon-plugin"
    "telnet"
    "zenity"
)

 for pkg in "${packages[@]}"; do
     echo "Installing $pkg"
     dnf install $pkg -y >/dev/null

     if [[ $? -ne 0 ]];then
	 echo "Error while trying to install $pkg" >&2
     fi
 done

echo "System packages are successfully installed"

# flatpaks
flatpak_repo="https://dl.flathub.org/repo/flathub.flatpakrepo"
flatpak remote-add --if-not-exists flathub $flatpak_repo &>/dev/null

flatpaks=(
    "com.bitwarden.desktop"
    "com.brave.Browser"
    "com.discordapp.Discord"
    "com.github.johnfactotum.Foliate"
    "com.github.wwmm.easyeffects"
    "com.vscodium.codium"
    "md.obsidian.Obsidian"
    "org.gnome.Papers"
    "org.signal.Signal"
    "org.kde.ark"
    "org.libreoffice.LibreOffice"
    "org.qbittorrent.qBittorrent"
    "org.mozilla.Thunderbird"
    "org.remmina.Remmina"
)

for flatpak in "${flatpaks[@]}" ; do
    echo "Installing $flatpak"
    flatpak install flathub --noninteractive $flatpak &>/dev/null

    if [[ $? -ne 0 ]];then
	echo "Error while trying to install $flatpak" >&2
    fi
done
