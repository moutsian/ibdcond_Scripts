#!/bin/bash

for ((i=1;i<=22;i++))
do
sh submit_all.sh UC "$i" 1
sh submit_all.sh IBD "$i" 1
sh submit_all.sh CD "$i" 1
done
