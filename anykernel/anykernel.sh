# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers
properties() { '
kernel.string="Quarzt Crystal 4.14"
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=ginkgo
supported.versions=
'; }

block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
patch_vbmeta_flag=0;

. tools/ak3-core.sh;

chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;
# If lk2nd is installed, Read boot from 1MB offset
if [ "$(dd if=${block} skip=64 bs=1 count=5 2>/dev/null)" == "lk2nd" ]; then
  ui_print "Detected lk2nd installation! Skipping the first 1MB."
  customdd="bs=1M skip=1"
  lk2nd=1
fi
dump_boot;
# Enable USB ConfigFS
patch_cmdline androidboot.usbconfigfs androidboot.usbconfigfs=true
ui_print "*******************************************"
ui_print "Updating Kernel and Patching cmdline..."
ui_print "*******************************************"
# If lk2nd is installed, Write boot to 1MB offset
if [ "$lk2nd" == "1" ]; then
  customdd="bs=1M seek=1"
  # GNU GREP: lk2nd_end=$(expr $(grep --byte-offset --only-matching --text SEANDROIDENFORCE ${block}|cut -d ':' -f 1) + 16)
  # AK3 grep: lk2nd_end=$(expr $(grep -o -n SEANDROIDENFORCE ${block}|cut -d ':' -f 1) + 16)
  # Recovery grep:
  lk2nd_end=$(expr $(/bin/grep -o -b -a SEANDROIDENFORCE ${block}|cut -d ':' -f 1) + 16)
  lk2nd_gaps=$(expr 1048576 - ${lk2nd_end})
  ui_print "Filling ${lk2nd_gaps} bytes of gap from lk2nd data (${lk2nd_end}) till 1MB with zeroes."
  dd if=/dev/zero of=$block bs=1 count=$lk2nd_gaps seek=$lk2nd_end
fi

write_boot;
