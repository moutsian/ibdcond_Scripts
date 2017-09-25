#!/bin/bash

#this is to correct the issue with values with >200Mb (which doesnt occur anymore)
trait=$1;
remainingfile="/lustre/scratch115/teams/anderson/ibd_conditional/results.${trait}.remaining.txt"

while read loci;
do
variants=($loci)  #### all i need is to make a file containing these information. I need to take the output from the
chr=${variants[0]}
pos=${variants[2]}
name=${variants[1]}
al1=${variants[3]}
al2=${variants[4]}
pval=${variants[5]}
wleft=${variants[6]}
wright=${variants[7]}

resfile="/lustre/scratch115/teams/anderson/ibd_conditional/results.${trait}.${chr}.txt"


results=($(grep "$name" "$resfile"))
window_left=${results[6]}

#now either overwrite that column or add to the end of the file
if [ "$window_left" == "NA" ]; then
#replace
original_line=$(grep "$name" "$resfile")
new_line2=$(grep "$name" "$remainingfile")
new_line="${chr} ${name} ${pos} ${al1} ${al2} ${pval} ${wleft} ${wright}"
#echo "original: ${original_line} and new: ${new_line}" #and new2: ${new_line2}"
sed -i "s/$original_line/$new_line/" /lustre/scratch115/teams/anderson/ibd_conditional/results.${trait}.${chr}.txt
fi
done < $remainingfile

