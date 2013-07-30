#!/bin/bash

wget https://launchpadlibrarian.net/83305348/cirros-0.3.0-x86_64-disk.img

glance add name="cirrOS-0.3.0-x86_64" is_public=true  container_format=bare  disk_format=qcow2 < cirros-0.3.0-x86_64-disk.img

sleep 1

nova image-list
