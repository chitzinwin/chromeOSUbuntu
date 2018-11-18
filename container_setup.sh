CONTAINER_NAME=cosmic

lxc image copy ubuntu:18.10 local: --alias ubuntu1810
lxc stop --force $CONTAINER_NAME
lxc delete $CONTAINER_NAME
lxc launch ubuntu1810 $CONTAINER_NAME
echo "Ignore warning messages"
sleep 5
lxc exec $CONTAINER_NAME -- rm /tmp/chromeos_setup.sh
lxc exec $CONTAINER_NAME -- curl -o /tmp/chromeos_setup.sh https://raw.githubusercontent.com/lafaspot/chromeOSUbuntu/master/chromeos_setup.sh
lxc exec $CONTAINER_NAME -- bash /tmp/chromeos_setup.sh
lxc list

echo "Use the following command to login to you container"
echo "lxc exec $CONTAINER_NAME -- su --login USER"

# to make the ubuntu the default container
# lxc stop penguin; lxc rename penguin origPenguin; lxc rename $CONTAINER_NAME penguin

