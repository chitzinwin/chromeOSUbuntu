# chromeOSUbuntu
Shell file to setup a ubuntu container on chromeos. This document is a reference how to use containers and VMs commands on chromeos crostini project. You can run Ubuntu, Debian and other linux flavors under chromeos VMs. Chromeos VMs are required to run the containers, the VMs where designed to boot fast and be secure and have the minimal files needed to run lxd containers and integrate with chromeos.

My test machine is a YOGA CHROMEBOOK C630, and chrome://system	shows my kernel and cpu like this:
Linux localhost 4.4.141-14567-g26df737f0737 #1 SMP PREEMPT Wed Oct 3 23:24:39 PDT 2018 x86_64 Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz GenuineIntel GNU/Linux

ii  cros-sftp                         0.13                              all          SFTP service files for CrOS integration This package
ii  openssh-sftp-server               1:7.4p1-10+deb9u4                 amd64        secure shell (SSH) sftp server module, for SFTP access from remote machines
lafaspot@google:~$ dpkg -l |grep ssh
ii  libssh2-1:amd64                   1.7.0-1                           amd64        SSH2 client-side library
ii  openssh-client                    1:7.4p1-10+deb9u4                 amd64        secure shell (SSH) client, for secure access to remote machines
ii  openssh-server                    1:7.4p1-10+deb9u4                 amd64        secure shell (SSH) server, for secure access from remote machines
ii  openssh-sftp-server               1:7.4p1-10+deb9u4                 amd64        secure shell (SSH) sftp server module, for SFTP access from remote machines

### Instructions to setup Ubuntu with chromeos integration
The command below will download the container_setup.sh and chromeos_setup.sh file from this project and execute the scripts on your chromeos VM and create a ubuntu container "cosmic" and will install the google required packages to integrate Ubuntu better with chromeos on the ubuntu container.

1. press Ctrl+alt+t
2. vsh termina 
3. run command below
```
rm /tmp/container_setup.sh;
curl -o /tmp/container_setup.sh https://raw.githubusercontent.com/lafaspot/chromeOSUbuntu/master/container_setup.sh;
bash /tmp/container_setup.sh
```

If you run the script a second time the cosmic container will be deleted and recreated. You can run it as many times as needed.

## Helpfull commands for vsh, vmc, lxc

### VM commands - basic gentoo VM compiled by google to be small and fast
```
vsh dev - get a console for that vm
vmc start dev - also gets you a console and starts a vm
vmc stop dev - stop a vm (does not do much)
vmc destroy dev - (only works sometimes)
vmc list
```

### Inside the VM - in a vm you can create multiple containers
```
run_container.sh --container_name=devCon --user=lafaspot
lxc list - list all VMs
lxc image list - list all VM images on the box
lxc remote list = list all remote indexes
```

### Create a debian stable vm, using chromeos utility shell file, that provides better integration with chromeos.
```
run_container.sh --container_name=devCon --user=USERID
```

### Setup a new container
```
lxc image copy ubuntu:18.10 local: --alias ubuntu1810
lxc launch ubuntu1810 cosmic
lxc exec cosmic -- bash

```

### Shutdown the new container and restart it
```
shutdown -h now
lxc start cosmic
```

### remove container
```
lxc stop --force cosmic
lxc delete cosmic
```

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

$ vmc --help
vmc [ start <name> | stop <name> | destroy <name> | export <vm name> <file name> [removable storage name] | list ]  
  Start or stop a VM.

$ vsh --help
vsh <name>  
  Connect to a shell inside the VM <name>.
```

### References

https://www.reddit.com/r/Crostini/comments/8fzp4r/running_different_distributions_in_containers/
