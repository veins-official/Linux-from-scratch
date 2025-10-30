COLD_DISK="$1"

sudo fdisk "$COLD_DISK" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
q
EOF

sudo mkfs -t ext2 -F "${COLD_DISK}1"
sudo mkfs -t ext4 -F "${COLD_DISK}2"

