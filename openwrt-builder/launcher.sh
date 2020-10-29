#!/bin/bash

env

git clone https://github.com/5g-empower/empower-openwrt.git ~/openwrt
git clone https://github.com/5g-empower/empower-configs.git ~/empower-configs

cd ~/openwrt
./scripts/feeds update -a
./scripts/feeds install -a
mkdir files

TARGETS="apu2c wdr4300 wndr4300 alix2d"


for TARGET in $TARGETS; do

	echo "Configuring target $TARGET"

	cp ~/empower-configs/$TARGET.config ~/openwrt/.config
	cp -r ~/empower-configs/empower-files-$TARGET/* ~/openwrt/files

	make defconfig

	echo "Begin compilation"
	make #-j1 V=s
	echo "End compilation"

done

FOLDER_NAME="$(date +"%Y-%m-%d-%H:%M")"
mkdir -p ~/builds/$FOLDER_NAME
cp -r ~/openwrt/bin ~/builds/$FOLDER_NAME/
