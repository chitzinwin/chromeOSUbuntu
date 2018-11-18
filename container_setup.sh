lxc image copy ubuntu:18.10 local: --alias ubuntu1810
lxc stop --force cosmic
lxc delete cosmic
lxc launch ubuntu1810 cosmic
lxc exec cosmic -- rm /tmp/container_setup.sh
lxc exec cosmic -- curl -o /tmp/container_setup.sh https://raw.githubusercontent.com/lafaspot/chromeOSUbuntu/master/container_setup.sh
lxc exec cosmic -- bash /tmp/container_setup.sh
