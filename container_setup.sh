CONTAINER_NAME=penguin

echo "Input the container name for ubuntu 18.10 <recomended: $CONTAINER_NAME>"
read CONTAINER_NAME
echo "Using container:$CONTAINER_NAME"
sleep 3

lxc image copy ubuntu:20.04 local: --alias focal
lxc stop --force $CONTAINER_NAME
lxc delete $CONTAINER_NAME
lxc launch focal $CONTAINER_NAME
echo "Ignore warning messages"
sleep 5
lxc exec $CONTAINER_NAME -- rm /tmp/chromeos_setup.sh
lxc exec $CONTAINER_NAME -- curl -o /tmp/chromeos_setup.sh https://raw.githubusercontent.com/chitzinwin/chromeOSUbuntu/master/chromeos_setup.sh
lxc exec $CONTAINER_NAME -- bash /tmp/chromeos_setup.sh

echo "Shutdwon the container in progress, type 'lxd exec -- bash' to login into the container"
sleep 3
lxc exec $CONTAINER_NAME -- shutdown -h now
lxc list
sleep 5
lxc start $CONTAINER_NAME
sleep 5

echo "Use the following command to login to you container"
echo "lxc exec $CONTAINER_NAME -- su --login USER"

# to make the ubuntu the default container
# lxc stop penguin; lxc rename penguin origPenguin; lxc rename $CONTAINER_NAME penguin

