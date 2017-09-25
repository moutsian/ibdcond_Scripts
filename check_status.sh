#!/bin/bash
trait=$1;
for((i=1;i<=22;i++))
do
completed=$(wc -l /lustre/scratch115/teams/anderson/ibd_conditional/results."$trait"."$i".txt|awk '{print $1}')
total=$(wc -l tophits_from_our_study/final_meta_analysis_C."$trait".5e_08.chr"$i".txt|awk '{print $1}')
echo "${trait}, chrom ${i}, Completed: ${completed} out of ${total}"
done
