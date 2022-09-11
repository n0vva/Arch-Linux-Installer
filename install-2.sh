#locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

#timezone
ln -sf /usr/share/zoneinfo/America/Yellowknife
hwclock --systohc

#hostname/hosts file
echo "What Will Your Hostname Be?"
read hostname

echo $hostname >> /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain     $hostname" >> /etc/hosts

#user account
echo "What Will Your User Be Named"
read user
useradd -mG wheel $user
usermod -aG wheel,audio,video,optical,storage $user
echo "root password:"
passwd
echo "$user password:"
passwd $user

#install some stuff
sudo pacman -S vim grub os-prober dosfstools mtools efibootmgr

#sudoers file
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#grub
echo "What is The EFI partition?"
read EFI
mkdir /boot/EFI
mount $EFI /boot/EFI

grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

#last minute tweaks
echo "What Packages Would You Like to Install?"
read packages
sudo pacman -S $packages networkmanager
sudo systemctl enable NetworkManager

#error checking
FILE="/etc/systemd/system/multi-user.target.wants/NetworkManager.service"
if [[ -f $FILE ]];then
	    echo "success"
    else
	        echo -e "\033[0;31m FAILED \033[0m"
		echo "What Packages Would You Like to Install?"
		read packages
		sudo pacman -S $packages networkmanager
		sudo systemctl enable NetworkManager
fi

#reboot
exit
umount -l /mnt
reboot