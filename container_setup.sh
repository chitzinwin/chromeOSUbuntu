lxc image copy ubuntu:18.10 local: --alias ubuntu1810
lxc stop --force cosmic
lxc delete cosmic
lxc launch ubuntu1810 cosmic
echo "Ignore warning messages"
sleep 5
lxc exec cosmic -- rm /tmp/chromeos_setup.sh
lxc exec cosmic -- curl -o /tmp/chromeos_setup.sh https://raw.githubusercontent.com/lafaspot/chromeOSUbuntu/master/chromeos_setup.sh
lxc exec cosmic -- bash /tmp/chromeos_setup.sh
lxc list

# to make the ubuntu the default container
# lxc stop penguin; lxc rename penguin origPenguin; lxc rename cosmic penguin

