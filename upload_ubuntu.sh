#!/bin/bash

wget http://stackgeek.s3.amazonaws.com/ubuntu-12.04-server-cloudimg-amd64-disk1.img

glance add name="Ubuntu 12.04 LTS" is_public=true container_format=ovf disk_format=qcow2 < ubuntu-12.04-server-cloudimg-amd64-disk1.img

sleep 1

nova image-list
