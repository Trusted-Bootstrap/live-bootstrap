#!/usr/bin/env bash

KERNEL=$(uname)
PLATFORM=$(uname -p)

([[ $KERNEL != "Darwin" ]] && [[ $KERNEL != "Linux" ]]) && 
  echo "Only Linux and Darwin hosts currently supported" && 
  exit
[[ $PLATFORM != "i386" ]] && 
  echo "Only x86 bootstrap currently supported" && 
  exit

ACEL=$([[ $KERNEL == "Darwin" ]] && echo "hvf" || echo "kvm")

qemu-system-x86_64 -accel $ACEL \
                   -m 6144M -smp 2 \
                   -drive file=target/boot.img,format=raw \
                   -machine kernel-irqchip=split \
                   -cpu host \
