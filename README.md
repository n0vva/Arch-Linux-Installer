Arch-Installer
Tutorial
(Assuming Your on a Brand New Archiso)
pacman -Sy git - Syncs Package Repos & Installs Git
git clone https://github.com/avvon/monkey-installer - Clones The Repo

sh install.sh - Starts The Installer In Bash
sh install-2.sh - Start Second Part In Bash

exit -Exits Arch Install
umount -l /mnt - Unmount Drives
reboot
Partitioning
Home And Root On Same Partition
g - GPT

n - New Partition
enter
enter
+550M

n - New Partition
enter
enter
+2G

n - New Partition
enter
enter
enter

t - Change Filesystem
1
1

t - Change Filesystem
2
19

w - Write Changes
Home And Root On Different Partitions
g - GPT

n - New Partition
enter
enter
+550M

n - New Partition
enter
enter
+2G

n - New Partition
enter
enter
+30G - Size Depends On Use Case

n - New Partition
enter
enter
enter

t - Change Filesystem
1
1

t - Change Filysystem
2
19

w - Write Changes
