#!/bin/bash

[ -d out ] && rm -rf out && mkdir -p out || mkdir -p out

TC_DIR=${HOME}/android/TOOLS/proton-clang
CFG_DIR=$(pwd)/arch/arm64/configs/
CFG=$CFG_DIR/vendor/ginkgo-perf_defconfig
export KBUILD_KVER=4.14.320-QuartzCrystal💎
[ -d $TC_DIR ] \
&& echo -e "\nProton-Clang Present.\n" \
|| echo -e "\nProton-Clang Not Present. Downloading Around 500MB...\n" \
| mkdir -p $TC_DIR \
| git clone --depth=1 https://github.com/kdrag0n/proton-clang $TC_DIR \
| echo "Done."

echo -e "\nChecking Clang Version...\n"
PATH="$TC_DIR/bin:${PATH}" clang --version
echo -e "\n\nStarting Build...\n"

cp $CFG $CFG_DIR/final_defconfig

pcmake() {
PATH="$TC_DIR/bin:${PATH}" \
make	\
	O=out \
	ARCH=arm64 \
	CC="ccache clang" \
	CXX="ccache clang++" \
	AR="ccache llvm-ar" \
	NM="ccache llvm-nm" \
	STRIP="ccache llvm-strip" \
	OBJCOPY="ccache llvm-objcopy" \
	OBJDUMP="ccache llvm-objdump"\
	OBJSIZE="ccache llvm-size" \
	READELF="ccache llvm-readelf" \
	HOSTCC="ccache clang" \
	HOSTCXX="ccache clang++" \
	HOSTAR="ccache llvm-ar" \
	HOSTNM="ccache llvm-nm" \
	CROSS_COMPILE="aarch64-linux-gnu-" \
	CROSS_COMPILE_ARM32="arm-linux-gnueabi-" \
	CONFIG_DEBUG_SECTION_MISMATCH=y \
	CONFIG_NO_ERROR_ON_MISMATCH=y -j $(nproc)\
	$1 $2 $3 || exit
}
