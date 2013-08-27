#!/bin/bash

vgchange -a n cinder && vgremove cinder
