lxc image copy ubuntu:18.10 local: --alias ubuntu1810
lxc stop --force cosmic
lxc delete cosmic
lxc launch ubuntu1810 cosmic
lxc exec cosmic -- rm chromeos_setup.sh
lxc exec cosmic -- wget https://raw.githubusercontent.com/lafaspot/chromeOSUbuntu/master/chromeos_setup.sh
lxc exec cosmic -- bash chromeos_setup.sh
