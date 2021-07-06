HOSTNAME=penguin
USER=winc

#echo "Input the hostname for this container <recomended: penguin>"
#read HOSTNAME
#echo "Input ubuntu desktop user name <recomended: same as chromeos username>"
#read USER

echo "Using hostname:$HOSTNAME"
echo "Using username:$USER"
sleep 3

rm -f cros-ui-config_0.12_all.deb
apt update -y
apt upgrade -y
echo "deb https://storage.googleapis.com/cros-packages stretch main" > /etc/apt/sources.list.d/cros.list

if [ -f /dev/.cros_milestone ]; then sudo sed -i "s?packages?packages/$(cat /dev/.cros_milestone)?" /etc/apt/sources.list.d/cros.list; fi

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1397BC53640DB551
apt update

# packages available in debian google install
apt -y install binutils
apt-get -y install adwaita-icon-theme-full 
apt -y install binutils adwaita-icon-theme-full adwaita-icon-theme apt-transport-https apt-utils at-spi2-core bash-completion ca-certificates cpp cpp-6 curl dbus-x11 dconf-cli dconf-gsettings-backend dconf-service desktop-file-utils dh-python distro-info-data fontconfig fontconfig-config fonts-croscore fonts-dejavu-core fonts-roboto fonts-roboto-hinted glib-networking glib-networking-common glib-networking-services gnome-icon-theme gsettings-desktop-schemas gtk-update-icon-cache hicolor-icon-theme i965-va-driver less lsb-release mesa-va-drivers mesa-vdpau-drivers mime-support openssl perl perl-modules perl-openssl-defaults policykit-1 publicsuffix pulseaudio pulseaudio-utils python-apt-common python3 python3-apt python3-minimal readline-common rename rtkit sgml-base shared-mime-info sudo tcpd ucf unattended-upgrades unzip va-driver-all vdpau-driver-all x11-common x11-utils x11-xserver-utils xdg-user-dirs xdg-utils xkb-data xml-core xz-utils
# extra packages
#apt -y install firefox

echo "### ignore any warning messages ###"
# ignore any warning messages
apt download cros-ui-config 
ar x cros-ui-config_0.12_all.deb data.tar.gz
gunzip data.tar.gz
tar f data.tar --delete ./etc/gtk-3.0/settings.ini
gzip data.tar
ar r cros-ui-config_0.12_all.deb data.tar.gz
rm -f data.tar.gz

# ignore any warning messages
# echo "### ignore any warning messages ###"
echo "apt install ./cros-ui-config_0.12_all.deb $CROSTINI_PKG"
apt -y install ./cros-ui-config_0.12_all.deb cros-adapta cros-apt-config cros-garcon cros-guest-tools cros-sommelier cros-sommelier-config cros-sudo-config cros-systemd-overrides cros-wayland cros-sftp
#apt-get -y install cros-guest-tools ./cros-ui-config_0.12_all.deb < /dev/null

sed -i 's/Ambiance/CrosAdapta/' /etc/gtk-3.0/settings.ini
sed -i 's/ubuntu-mono-dark/CrosAdapta/' /etc/gtk-3.0/settings.ini
sed -i 's/gtk-sound-theme-name = ubuntu/gtk-font-name = Roboto 11/' /etc/gtk-3.0/settings.ini
sed -i '5d' /etc/gtk-3.0/settings.ini
sed -i -n '2{h;n;G};p' /etc/gtk-3.0/settings.ini

# clean up
# rm -rf cros-ui-config_0.12_all.deb

sed -i "1c$HOSTNAME" /etc/hostname

killall -u ubuntu
groupmod -n $USER ubuntu
usermod -md /home/$USER -l $USER ubuntu
usermod -aG users $USER
loginctl enable-linger $USER
sed -i "s/ubuntu/$USER/" /etc/sudoers.d/90-cloud-init-users

loginctl enable-linger $USER
sleep 3

