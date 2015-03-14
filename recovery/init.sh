#!/sbin/busybox sh
set +x
_PATH="$PATH"
export PATH=/sbin

RED_LED="/sys/class/leds/red/brightness"
GREEN_LED="/sys/class/leds/green/brightness"
BLUE_LED="/sys/class/leds/blue/brightness"

EVENT_NODE="/dev/input/event1 c 13 65"
EVENT="/dev/input/event1"
FOTA_NODE="/dev/block/mmcblk0p11 b 179 11"
FOTA="/dev/block/mmcblk0p11"

busybox cd /
busybox date >>boot.txt
exec >>boot.txt 2>&1
busybox rm /init

# create directories
busybox mkdir -m 755 -p /dev/block
busybox mkdir -m 755 -p /dev/input
busybox mkdir -m 555 -p /proc
busybox mkdir -m 755 -p /sys

# create device nodes
busybox mknod -m 600 /dev/block/mmcblk0 b 179 0
busybox mknod -m 600 ${EVENT_NODE}
busybox mknod -m 666 /dev/null c 1 3

# mount filesystems
busybox mount -t proc proc /proc
busybox mount -t sysfs sysfs /sys

# trigger ON amber LED
busybox echo 255 > ${RED_LED}
busybox echo 0 > ${GREEN_LED}
busybox echo 255 > ${BLUE_LED}

# keycheck
busybox cat ${EVENT} > /dev/keycheck&
busybox sleep 3

# trigger OFF amber LED
busybox echo 0 > ${RED_LED}
busybox echo 0 > ${GREEN_LED}
busybox echo 0 > ${BLUE_LED}

# android ramdisk
load_image=/sbin/ramdisk.cpio

# boot decision
if [ -s /dev/keycheck ] || busybox grep -q warmboot=0x77665502 /proc/cmdline ; then
    busybox echo 'RECOVERY BOOT' >>boot.txt
    # cyan led for recoveryboot
    busybox echo 0 > ${RED_LED}
    busybox echo 255 > ${GREEN_LED}
    busybox echo 255 > ${BLUE_LED}
    # recovery ramdisk
    busybox mknod -m 600 ${FOTA_NODE}
    busybox mount -o remount,rw /
    busybox ln -sf /sbin/busybox /sbin/sh
    extract_elf_ramdisk -i ${FOTA} -o /sbin/ramdisk-recovery.cpio -t / -c
    busybox rm /sbin/sh
    load_image=/sbin/ramdisk-recovery.cpio
else
    busybox echo 'ANDROID BOOT' >>boot.txt
    # poweroff LED
    busybox echo 0 > ${RED_LED}
    busybox echo 0 > ${GREEN_LED}
    busybox echo 0 > ${BLUE_LED}
fi

# kill the keycheck process
busybox pkill -f "busybox cat ${EVENT}"

# unpack the ramdisk image
busybox cpio -i < ${load_image}

busybox umount /proc
busybox umount /sys

busybox rm -fr /dev/*
busybox date >>boot.txt
export PATH="${_PATH}"
exec /init
