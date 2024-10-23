#!/usr/bin/env bash



make_image() {
  dd bs=1G count=16 if=/dev/zero of=./target/boot.img &&
    dd bs=512 conv=notrunc if=./target/init.img of=./target/boot.img
}

./download-distfiles.sh &&
  rm -rf target &&
  source ./venv/bin/activate &&
  (./rootfs.py -b &> /dev/null) && make_image

