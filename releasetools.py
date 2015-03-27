import os
import shutil

PRODUCT_OUT = os.getenv('OUT')


def FullOTA_Assertions(self):
    """Directly copy boot.img to OTA target temporary directory"""
    bootimage = os.path.join(PRODUCT_OUT, 'boot.img')
    prebuilt_dir = os.path.join(self.input_tmp, 'BOOTABLE_IMAGES')
    os.mkdir(prebuilt_dir)
    shutil.copy(bootimage, prebuilt_dir)


def IncrementalOTA_Assertions(self):
    """Directly copy boot.img to OTA target temporary directory"""
    bootimage = os.path.join(PRODUCT_OUT, 'boot.img')
    prebuilt_dir = os.path.join(self.input_tmp, 'BOOTABLE_IMAGES')
    os.mkdir(prebuilt_dir)
    shutil.copy(bootimage, prebuilt_dir)
