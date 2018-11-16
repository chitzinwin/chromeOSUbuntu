rm -f cros-ui-config_0.12_all.deb
apt update
apt upgrade
echo "deb https://storage.googleapis.com/cros-packages stretch main" > /etc/apt/sources.list.d/cros.list

if [ -f /dev/.cros_milestone ]; then sudo sed -i "s?packages?packages/$(cat /dev/.cros_milestone)?" /etc/apt/sources.list.d/cros.list; fi

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1397BC53640DB551
apt update
apt install binutils

echo "### ignore any warning messages ###"
# ignore any warning messages
apt download cros-ui-config 
ar x cros-ui-config_0.12_all.deb data.tar.gz
gunzip data.tar.gz
tar f data.tar --delete ./etc/gtk-3.0/settings.ini
gzip data.tar
ar r cros-ui-config_0.12_all.deb data.tar.gz
rm -f data.tar.gz

apt install .cros-adapta cros-apt-config cros-garcon cros-guest-tools cros-sftp cros-sommelier cros-sommelier-config cros-sudo-config cros-systemd-overrides cros-unattended-upgrades cros-wayland

# ignore any warning messages
echo "### ignore any warning messages ###"
dpkg -i /cros-ui-config_0.12_all.deb

sed -i 's/Ambiance/CrosAdapta/' /etc/gtk-3.0/settings.ini
sed -i 's/ubuntu-mono-dark/CrosAdapta/' /etc/gtk-3.0/settings.ini
sed -i 's/gtk-sound-theme-name = ubuntu/gtk-font-name = Roboto 11/' /etc/gtk-3.0/settings.ini
sed -i '5d' /etc/gtk-3.0/settings.ini
sed -i -n '2{h;n;G};p' /etc/gtk-3.0/settings.ini

# clean up
# rm -rf cros-ui-config_0.12_all.deb

HOSTNAME=ubuntu1810
USER=guest

echo "Input the hostname for this container"
read HOSTNAME
echo "Input ubuntu desktop user name <recomended: same as chromeos username>"
read USER

sed -i "1c$HOSTNAME" /etc/hostname

killall -u ubuntu
groupmod -n $USER ubuntu
usermod -md /home/$USER -l $USER ubuntu
usermod -aG users $USER
loginctl enable-linger $USER
sed -i "s/ubuntu/$USER/" /etc/sudoers.d/90-cloud-init-users

