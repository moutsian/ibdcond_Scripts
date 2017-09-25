#!/bin/bash
shopt -s nullglob

head -n1 "/lustre/scratch113/projects/crohns/iibdgc_meta/results/finemap/12_68492980_CSQ.confset" > "/lustre/scratch115/teams/anderson/ibd_conditional/high_pcausal_CSQ.confset"
array3=(/lustre/scratch113/projects/crohns/iibdgc_meta/results/finemap/*CSQ*)
for i in ${array3[*]}
do
echo "$i\n"
cat ${i} | awk -v FILE="$i" '{split(FILE,arr,"/");split(arr[9],arr2,".");split(arr2[1],arr3,"_");if($3!="NA" && $3>=0.5){print arr3[1]"_"arr3[2]"\t"$0;}}'| grep -v "P_CUMSUM"  >> "/lustre/scratch115/teams/anderson/ibd_conditional/high_pcausal_CSQ.confset"
done
