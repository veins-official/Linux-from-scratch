export COLD=""
cd /sources

cat > /etc/fstab << "EOF"
# Begin /etc/fstab

/dev/sda2 / ext4 defaults 1 1
/dev/sda1 /boot ext2 defaults 0 0

proc /proc proc nosuid,noexec,nodev 0 0
sysfs /sys sysfs nosuid,noexec,nodev 0 0
devpts /dev/pts devpts gid=5,mode=620 0 0
tmpfs /run tmpfs defaults 0 0
devtmpfs /dev devtmpfs mode=0755,nosuid 0 0
tmpfs /dev/shm tmpfs nosuid,nodev 0 0
cgroup2 /sys/fs/cgroup cgroup2 nosuid,noexec,nodev 0 0

# End /etc/fstab
EOF


source packageinstall.sh 10 linux

cp -iv arch/x86/boot/bzImage /boot/vmlinuz-6.13.4-lfs-12.3
cp -iv System.map /boot/System.map-6.13.4
cp -iv .config /boot/config-6.13.4
cp -r Documentation -T /usr/share/doc/linux-6.13.4


install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf
install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true
# End /etc/modprobe.d/usb.conf
EOF

grub-install --target i386-pc /dev/sda

cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5
insmod part_gpt
insmod ext2
set root=(hd0,1)
set gfxpayload=1024x768x32
menuentry "Cold Linux, 1.0" {
	linux /vmlinuz-6.13.4-lfs-12.3 root=/dev/sda2 ro vga=normal
}
EOF

