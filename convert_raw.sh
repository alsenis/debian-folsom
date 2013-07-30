#!/bin/bash

# see http://6.ptmc.org/357

qemu-img convert -O raw $1 $1.raw
