#!/usr/bin/env bash

KERNEL=$(uname)
MACHINE=$(uname -m)

([[ $KERNEL != "Darwin" ]] && [[ $KERNEL != "Linux" ]]) && 
  echo "Only Linux and Darwin hosts currently supported" && 
  exit
[[ $MACHINE != "x86_64" ]] && 
  echo "Only x86_64 host bootstrap currently supported" && 
  exit

ACEL=$([[ $KERNEL == "Darwin" ]] && echo "hvf" || echo "kvm")

qemu-system-x86_64 -accel $ACEL \
                   -m 6144M -smp 2 \
                   -drive file=target/boot.img,format=raw \
                   -machine kernel-irqchip=split \
                   -cpu host \
