#!/bin/bash

ak_dir=anykernel/any
image=out/arch/arm64/boot/Image.gz-dtb
dtbimg=out/arch/arm64/boot/dtbo.img
pre=` cat out/.config | grep Linux | cut -f 3 -d " "  `
fmt=`date +%d\.%m\.%y_%r | sed 's/:/./g;s/ PM/.PM/g;s/ AM/.AM/g;s/ IST//g'`

rm -rf anykernel3

mkdir -p $ak_dir 
git clone --depth=1 https://github.com/osm0sis/AnyKernel3 $ak_dir
rm $ak_dir/anykernel.sh
cp anykernel/anykernel.sh $ak_dir
#cp -f anykernel/ak3-core.sh $ak_dir/tools/
cp -rf $image $ak_dir/
cp -rf $dtbimg $ak_dir/
cd $ak_dir

zip -r9 QuartzCrystal-4.14_${model}_${fmt}.zip *
mv *.zip ../../
cd ../../
