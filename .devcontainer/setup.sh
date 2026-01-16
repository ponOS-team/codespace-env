#!/bin/bash
# Ставим права, чтобы не вводить sudo каждый раз для входа
echo "alias enter='sudo /usr/local/bin/enter-chroot'" >> ~/.bashrc

# Сам скрипт входа (создаем его через sudo)
sudo tee /usr/local/bin/enter-chroot <<'EOF'
#!/bin/bash
ROOTFS="/workspaces/$(basename $PWD)/alpine_rootfs"
# Проверка монтирования, чтобы не дублировать
mountpoint -q $ROOTFS/proc || {
    mount --bind /dev $ROOTFS/dev
    mount --bind /proc $ROOTFS/proc
    mount --bind /sys $ROOTFS/sys
    mount --make-rslave $ROOTFS/sys # важно для некоторых сборок
    cp /etc/resolv.conf $ROOTFS/etc/resolv.conf
}
chroot $ROOTFS /bin/sh
EOF

sudo chmod +x /usr/local/bin/enter-chroot
