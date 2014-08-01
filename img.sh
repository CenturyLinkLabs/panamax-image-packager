#!/bin/sh

drives=( `ls /dev/sd*` ); for i in "${drives[@]}"; do  if [[ "`df -k | grep $i`" == "" ]]; then imageDrive=$i; fi; done;
echo $imageDrive
