#!/bin/bash

# Do not touch this.

source anykernel/build_helper.sh

[[ $1 == 'g'   ]] && export model=ginkgo

BUILD_START=$(date +"%s")

make O=out ARCH=arm64 final_defconfig

[[ $2 != 'dtb' ]] && pcmake -j 20 || pcmake dtbs

DIFF=$(($(date +"%s") - $BUILD_START))
echo -e "\nBuild succeeded in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."

[[ $2 != 'dtb' ]] && ./anykernel/build_zip.sh 

unset model
rm arch/arm64/configs/final_defconfig
