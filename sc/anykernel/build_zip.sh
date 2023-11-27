#!/bin/bash

ak_dir=anykernel/any
image=out/arch/arm64/boot/Image.gz-dtb
dtbimg=out/arch/arm64/boot/dtbo.img
pre=` cat out/.config | grep Linux | cut -f 3 -d " "  `
fmt=`date +%d\.%m\.%y_%r | sed 's/:/./g;s/ PM/.PM/g;s/ AM/.AM/g;s/ IST//g'`

cp -rf $image $ak_dir/
cp -rf $dtbimg $ak_dir/
cd $ak_dir

zip -r9 QuartzCrystal-4.14-A11_${model}_${fmt}.zip *
mv *.zip ../../
cd ../../
