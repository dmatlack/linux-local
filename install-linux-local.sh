#!/bin/bash
#
# Install a linux-local kernel package on a target machine. The target machine
# is assumed to be running archlinux and using GRUB as its bootloader.

_remote=$1
_package=$2
_basename=$(basename $_package)

package_local=${_package}
package_remote="/tmp/linux-local/$(basename ${package_local})"

echo "::: Copying kernel package to ${_remote}."
ssh root@${_remote} -- "mkdir -p /tmp/linux-local/; rm -rf /tmp/linux-local/*"
scp ${package_local} root@${_remote}:${package_remote}

echo "::: Installing kernel package."
ssh root@${_remote} -- "pacman -U ${package_remote}"

echo "::: Updating grub menu."
ssh root@${_remote} -- "grub-mkconfig -o /boot/grub/grub.cfg"

echo "::: ${_remote} down for reboot."
ssh root@${_remote} -- "reboot"

echo "::: Waiting for ${_remote} to come back up..."
sleep 1
until ssh root@${_remote} -- "uname -a" 2>/dev/null; do sleep 5; done
exit 0
