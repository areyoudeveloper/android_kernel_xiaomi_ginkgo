#!/bin/bash

[ -d out ] && rm -rf out && mkdir -p out || mkdir -p out

TC_DIR=${HOME}/android/TOOLS/google-clang17.0.4
GCC_DIR=${HOME}/android/TOOLS/aarch64-linux-gnu
GCC32_DIR=${HOME}/android/TOOLS/gcc32
CFG_DIR=$(pwd)/arch/arm64/configs/
CFG=$CFG_DIR/vendor/ginkgo-perf_defconfig
export KBUILD_KVER=4.14.328-QuartzCrystal💎
[ -d $TC_DIR ] && [ -d $GCC_DIR ] && [ -d $GCC32_DIR ] \
&& echo -e "\nG-Clang Present.\n" \
|| echo -e "\nG-Clang Not Present. Downloading Around 800MB...\n" \
| mkdir -p $TC_DIR && mkdir -p $GCC_DIR && mkdir -p $GCC32_DIR \
| git clone https://gitlab.com/areyoudeveloper/google-clang17.0.4 -b 17 --depth 1 $TC_DIR \
&& git clone https://github.com/najahiiii/aarch64-linux-gnu -b gcc8-201903-A --depth 1 $GCC_DIR \
&& git clone https://github.com/najahiiii/aarch64-linux-gnu -b 4.9-32-mirror --depth 1 $GCC32_DIR \
| echo "Done."

echo -e "\nChecking Clang Version...\n"
PATH="$TC_DIR/bin:${PATH}" clang --version
echo -e "\n\nStarting Build...\n"

cp $CFG $CFG_DIR/final_defconfig

pcmake() {
PATH="$TC_DIR/bin:$GCC_DIR/bin:$GCC32_DIR/bin:${PATH}" \
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
	CROSS_COMPILE_ARM32="arm-linux-androideabi-" \
	CONFIG_DEBUG_SECTION_MISMATCH=y \
	CONFIG_NO_ERROR_ON_MISMATCH=y -j $(nproc)\
	$1 $2 $3 || exit
}
