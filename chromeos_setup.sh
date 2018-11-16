apt update
apt upgrade
echo "deb https://storage.googleapis.com/cros-packages stretch main" > /etc/apt/sources.list.d/cros.list

if [ -f /dev/.cros_milestone ]; then sudo sed -i "s?packages?packages/$(cat /dev/.cros_milestone)?" /etc/apt/sources.list.d/cros.list; fi

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1397BC53640DB551
apt update
apt install binutils
echo "### ignore any warning messages ###"
apt download cros-ui-config 
ar x cros-ui-config_0.12_all.deb data.tar.gz
gunzip data.tar.gz
tar f data.tar --delete ./etc/gtk-3.0/settings.ini
gzip data.tar
ar r cros-ui-config_0.12_all.deb data.tar.gz
rm -rf data.tar.gz
