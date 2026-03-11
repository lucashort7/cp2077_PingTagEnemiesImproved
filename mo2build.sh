#!/bin/bash

export MO2_ROOT_DIR="/mnt/c/Modding/MO2/"
export MO2_MOD_DIR="/mnt/c/Modding/MO2/mods/cp2077_PingTagEnemiesImproved/"

# pack files to MO2
rm -rf $MO2_MOD_DIR/r6
rsync -a ./r6 $MO2_MOD_DIR

# overwrite to dump
rsync -a $MO2_ROOT_DIR/overwrite/ $MO2_ROOT_DIR/mods/dmp_overwrite_files/
rm -rf $MO2_ROOT_DIR/overwrite/*