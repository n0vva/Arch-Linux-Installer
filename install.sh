#clock thing
timedatectl set-ntp true

#partitioning

lsblk
echo "What Disk Are You Going to Use? // Your Second Drive // e.x /dev/vda"
read disk
fdisk $disk

#efi partition
lsblk
echo "What Partition is EFI?"
read EFI
mkfs.fat -F32 $EFI

#swap partition
echo "Swap? [y/n]"
read swapyesno
if [[ $swapyesno == y* ]]; then
	echo "What Partition is Swap?"
	read swap 
	mkswap $swap
	swapon $swap
else
	echo "Skipping"
fi

#root partition
echo "What is the Root Partition"
read root
mkfs.ext4 $root

#home
echo "Seperate Home? [y/n]"
read homeyesno
if [[ $homeyesno == y* ]]; then
	echo "What Partition is Home?"
	read home
	mkfs.ext4 $home
	mkdir /mnt/home
	mount $home /mnt/home
else
	echo "Skipping"
fi

#pacstrap, mount
mount $root /mnt
pacstrap /mnt base base-devel linux linux-firmware

#fstab
genfstab -U /mnt >> /mnt/etc/fstab

#start second part
mv install-2.sh /mnt
echo "Please Start The Next Script!"
arch-chroot /mnt