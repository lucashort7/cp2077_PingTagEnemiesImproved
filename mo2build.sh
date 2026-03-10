#!/bin/bash

export MO2_MOD_DIR="/mnt/c/Modding/MO2/mods/cp2077_PingTagEnemiesImproved/"

rm -rf $MO2_MOD_DIR/r6
rsync -a ./r6 $MO2_MOD_DIR
