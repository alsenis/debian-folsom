#!/bin/bash

#http://docs.openstack.org/trunk/openstack-image/content/ch_converting.html
# see http://6.ptmc.org/357

qemu-img convert -O raw $1 $1.raw
