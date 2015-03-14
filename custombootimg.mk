INITSH := device/sony/hikari/recovery/init.sh
MKBOOTIMG := device/sony/hikari/tools/mkelf.py

uncompressed_ramdisk := $(PRODUCT_OUT)/ramdisk.cpio
$(uncompressed_ramdisk): $(INSTALLED_RAMDISK_TARGET)
	$(hide) $(MKBOOTFS) $(TARGET_ROOT_OUT) > $@

$(recovery_uncompressed_ramdisk): $(recovery_ramdisk) $(TARGET_RECOVERY_ROOT_OUT)/etc/twrp.fstab
	$(hide) $(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $@

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INSTALLED_KERNEL_TARGET) $(uncompressed_ramdisk) $(recovery_uncompressed_ramdisk) $(INITSH) $(MINIGZIP) $(PRODUCT_OUT)/utilities/busybox $(PRODUCT_OUT)/utilities/extract_elf_ramdisk
	$(call pretty,"Boot image: $@")

	$(hide) rm -rf $(PRODUCT_OUT)/combinedroot
	$(hide) mkdir -p $(PRODUCT_OUT)/combinedroot/sbin

	$(hide) mv $(PRODUCT_OUT)/root/logo.rle $(PRODUCT_OUT)/combinedroot/logo.rle
	$(hide) cp $(uncompressed_ramdisk) $(PRODUCT_OUT)/combinedroot/sbin/
	$(hide) cp $(recovery_uncompressed_ramdisk) $(PRODUCT_OUT)/combinedroot/sbin/
	$(hide) cp $(PRODUCT_OUT)/utilities/busybox $(PRODUCT_OUT)/combinedroot/sbin/
	$(hide) cp $(PRODUCT_OUT)/utilities/extract_elf_ramdisk $(PRODUCT_OUT)/combinedroot/sbin/

	$(hide) cp $(INITSH) $(PRODUCT_OUT)/combinedroot/sbin/init.sh
	$(hide) chmod 755 $(PRODUCT_OUT)/combinedroot/sbin/init.sh
	$(hide) ln -s sbin/init.sh $(PRODUCT_OUT)/combinedroot/init

	$(hide) $(MKBOOTFS) $(PRODUCT_OUT)/combinedroot/ | $(MINIGZIP) > $(PRODUCT_OUT)/combinedroot.fs

	$(hide) $(MKBOOTIMG) -o $@ \
	    $(INSTALLED_KERNEL_TARGET)@0x40208000 \
	    $(PRODUCT_OUT)/combinedroot.fs@0x41500000,ramdisk \
	    vendor/sony/hikari/proprietary/boot/RPM.bin@0x20000,rpm
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE))

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(INSTALLED_KERNEL_TARGET) $(recovery_ramdisk)
	$(call pretty,"Recovery image: $@")
	$(hide) $(MKBOOTIMG) -o $@ \
	    $(INSTALLED_KERNEL_TARGET)@0x40208000 \
	    $(recovery_ramdisk)@0x41500000,ramdisk \
	    vendor/sony/hikari/proprietary/boot/RPM.bin@0x20000,rpm
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE))
