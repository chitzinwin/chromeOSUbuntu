# chromeOSUbuntu
Shell file to setup you ubuntu container to integrate with chromeos. This document is just a reference for containers and VM commands form chromeos crostini project. You can run Ubuntu, Debian and other linux flavors under chromeos VMs. Chrome os VMs are required to run the containers, the VMs where designed to be fast to boot and secure and have the minal files need to run  lxd containers and integrate with chromeos.

### VM commands - basic gentoo VM compiled by google to be small and fast
vsh dev - get a console for that vm
vmc start dev - also gets you a console and starts a vm
vmc stop dev - stop a vm (does not do much)
vmc destroy dev - (only works sometimes)
vmc list

### Inside the VM - in a vm you can create multiple containers
run_container.sh --container_name=devCon --user=lafaspot
lxc list - list all VMs
lxc image list - list all VM images on the box

### Create a debian stable vm, using chromeos utility shell file, that provides better integration with chromeos.
run_container.sh --container_name=devCon --user=USERID

### Ubuntu setup
lxc image copy ubuntu:18.10 local: --alias ubuntu1810
lxc launch ubuntu1810 cosmic
lxc exec cosmic -- bash

### Now to setup Ubuntu with some chromeos integration here some steps

wget https://raw.githubusercontent.com/lafaspot/chromeOSUbuntu/master/chromeos_setup.sh; bash chromeos_setup.sh


### Help dumps for the vm and container commands available on chromeos
```
$ run_container.sh --help
USAGE: /usr/bin/run_container.sh [flags] args
flags:
  --[no]dummy:  Dummy run. Exit successfully immediately. (default: false)
  --container_name:  The name of the container (default: '')
  --container_token:  The garcon access token for the container (default: '')
  --lxd_image:  The image to create a container from (default: 'debian/stretch')
  --lxd_remote:  The LXD remote URL (default: 'https://storage.googleapis.com/cros-containers')
  --[no]shell:  Launch a login shell in the container when the script is complete. (default: false)
  --user:  The main user for the container (default: '')
  --guest_private_key:  The private SSH key for the guest container (default: '')
  --host_public_key:  The SSH public key for the CrOS host (default: '')
  -h,--[no]help:  show this help (default: false)

$ lxc --help
Description:
  Command line client for LXD
  
  All of LXD's features can be driven through the various commands below.
  For help with any of those, simply call them with --help.
  
Usage:
  lxc [command]

Available Commands:
  alias       Manage command aliases
  cluster     Manage cluster members
  config      Manage container and server configuration options
  console     Attach to container consoles
  copy        Copy containers within or in between LXD instances
  delete      Delete containers and snapshots
  exec        Execute commands in containers
  file        Manage files in containers
  help        Help about any command
  image       Manage images
  info        Show container or server information
  list        List containers
  move        Move containers within or in between LXD instances
  network     Manage and attach containers to networks
  operation   List, show and delete background operations
  profile     Manage profiles
  publish     Publish containers as images
  remote      Manage the list of remote servers
  rename      Rename containers and snapshots
  restore     Restore containers from snapshots
  snapshot    Create container snapshots
  start       Start containers
  storage     Manage storage pools and volumes

Flags:
      --all           Show less common commands
  -d, --debug         Show all debug messages
      --force-local   Force using the local unix socket
  -h, --help          Print help
  -v, --verbose       Show all information messages
      --version       Print version number

Use "lxc [command] --help" for more information about a command.
```

### References

https://www.reddit.com/r/Crostini/comments/8fzp4r/running_different_distributions_in_containers/
