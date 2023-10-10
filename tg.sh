#! /usr/bin/env bash
export CID=-361290223
export PATH=$PATH:~/bin/:/usr/bin
export DEBIAN_FRONTEND=noninteractive
export TZ=Asia/Jakarta
export TIME=$(date +"%S-%F")
 ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
 dpkg-reconfigure --frontend noninteractive tzdata

 apt-get install -y tzdata
 apt-get update -qq && \
    apt-get install --no-install-recommends -y \
	autoconf \
	autogen \
	automake \
	autotools-dev \
	bc \
	binutils \
	binutils-aarch64-linux-gnu \
	binutils-arm-linux-gnueabi \
	bison \
	bzip2 \
	ca-certificates \
	coreutils \
	cmake \
	ccache \
	curl \
	expect \
	flex \
	g++ \
	gawk \
	gcc \
	git \
	gnupg \
	gperf \
	help2man \
	lftp \
	libc6-dev \
	libelf-dev \
	libgomp1-* \
	liblz4-tool \
	libncurses5-dev \
	libssl-dev \
	libstdc++6 \
	libtool \
	libtool-bin \
	m4 \
	make \
	nano \
	openjdk-8-jdk \
	openssh-client \
	openssl \
	ovmf \
	patch \
	pigz \
	python3 \
	python \
	rsync \
	shtool \
	subversion \
	tar \
	texinfo \
	tzdata \
	u-boot-tools \
	unzip \
	wget \
	xz-utils \
	zip \
	zlib1g-dev \
	zstd
# git clone https://github.com/rohit12043/msm_4.9_rolex --depth 1
# git clone https://github.com/areyoudeveloper/GoGreen_kernel_4.9_land --depth 1
# git clone https://github.com/areyoudeveloper/GG_kernel_msm8917.git --depth 1
# git clone https://github.com/areyoudeveloper/anykernel3-spectrum
# git clone https://github.com/areyoudeveloper/anykernel-ggland.git
# git clone https://github.com/najahiiii/aarch64-linux-gnu.git -b linaro8-20190402
# git clone --depth=1 --single-branch https://github.com/AOSPA/android_prebuilts_gcc_linux-x86_arm_arm-eabi -b master gcc32
# git clone --depth=1 --single-branch https://github.com/AOSPA/android_prebuilts_gcc_linux-x86_aarch64_aarch64-elf -b master gcc
# git clone --depth=1 --single-branch https://github.com/HANA-CI-Build-Project/proton-clang -b master clang 
# git clone --depth=1 https://github.com/KudProject/prebuilts_clang_host_linux-x86 clang
# git clone --depth=1 https://github.com/KudProject/prebuilts_clang_host_linux-x86 clang
# git clone --depth=1 https://github.com/KudProject/arm-linux-androideabi-4.9 gcc32
# git clone --depth=1 https://github.com/KudProject/aarch64-linux-android-4.9 gcc
# git clone https://github.com/najahiiii/aarch64-linux-gnu.git -b gcc8-201903-A --depth 1 gcc
# export LD_LIBRARY_PATH=$(pwd)/clang/bin/../lib:$PATH 
# export PATH=$(pwd)/clang/bin:$(pwd)/gcc/bin:$(pwd)/gcc32/bin:$PATH
# echo bulding!!
chmod +x sc/*.sh
cp -rf sc/* .
chmod +x build_kernel.sh
./build_kernel.sh g
export OWO=$(ls *.zip)

if [ -f "$OWO" ]; then
    curl -F document=@$OWO "https://api.telegram.org/bot"$TOKEN"/sendDocument" \
        -F chat_id=$CID \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html"
	
    curl -s -X POST "https://api.telegram.org/bot"$TOKEN"/sendMessage" \
        -d chat_id=$CID \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=html" \
        -d text="Build Succeded  🥳 🥳 🥳 🥳 🥳 🥳"
else 
    curl -s -X POST "https://api.telegram.org/bot"$TOKEN"/sendMessage" \
        -d chat_id=$CID \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=html" \
        -d text="Build Failed"
fi

