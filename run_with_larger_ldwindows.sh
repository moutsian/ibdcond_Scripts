#!/bin/bash

# this is to correct the issue with values with >200Mb (which doesnt occur anymore)
# trait=$1;
# ldfile="/lustre/scratch115/teams/anderson/ibd_conditional/final_meta_analysis_C_results/${trait}/variants_to_rerun_ldcalc_for.${trait}.filtered.txt"

ldfile="/nfs/users/nfs_l/lm12/IBD_conditional/novel_hits_to_get_extended_ld_info_for.txt"

while read loci;
do
variants=($loci)  #### all i need is to make a file containing these information. I need to take the output from the
chr=${variants[1]}
pos=${variants[3]}
name=${variants[2]}
trait=${variants[0]}
wright=$(( $pos + 1500000 )) 
wleft=$(( $pos - 1500000 ))

if [ "$wleft" -le 0 ];then
wleft=0
fi
 echo "wleft: ${wleft} and  wright: ${wright} for variant ${name} at ${pos}"

/software/hgi/pkglocal/tabix-git-1ae158a/bin/tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chr}:${wleft}-${wright}" > tabix.out."${chr}"."${wleft}"."${wright}".vcf
/software/hgi/pkglocal/plink-1.90b2f/bin/plink --vcf tabix.out."${chr}"."${wleft}"."${wright}".vcf --ld-window-kb 6000 --ld-window 999999 --ld-window-r2 0.1  --r2 --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink --threads 5  --silent --out plink_ld.out."${chr}"."${wleft}"."${wright}"
grep "$pos" plink_ld.out."${chr}"."${wleft}"."${wright}".ld > plink_ld.out."${chr}"."${wleft}"."${wright}".ld.tmp

min1=$( cat plink_ld.out."${chr}"."${wleft}"."${wright}".ld.tmp | awk 'BEGIN {min = 400000000} {if ($2<min) min=$2} END {print min}')
min2=$( cat plink_ld.out."${chr}"."${wleft}"."${wright}".ld.tmp | awk 'BEGIN {min = 400000000} {if ($5<min) min=$5} END {print min}')
max1=$( cat plink_ld.out."${chr}"."${wleft}"."${wright}".ld.tmp | awk 'BEGIN {max = 0} {if ($2>max) max=$2} END {print max}')
max2=$( cat plink_ld.out."${chr}"."${wleft}"."${wright}".ld.tmp | awk 'BEGIN {max = 0} {if ($5>max) max=$5} END {print max}')
min=$(($min1<$min2?$min1:$min2))
max=$(($max1>$max2?$max1:$max2))


#resfile="/lustre/scratch115/teams/anderson/ibd_conditional/final_meta_analysis_C_results/${trait}/results.${trait}.${chr}.txt"


#now replace
original_line=$(grep "$pos" "$ldfile"|awk -v POS="$pos" '{if($4==POS){print $0;}}')
#new_line2=$(grep "$name" "$remainingfile")
new_line="${trait} ${chr} ${name} ${pos} ${min} ${max}"
echo "original: ${original_line} and new: ${new_line}"
sed -i "s/$original_line/$new_line/g" "/nfs/users/nfs_l/lm12/IBD_conditional/novel_hits_to_get_extended_ld_info_for.txt"

done < $ldfile

