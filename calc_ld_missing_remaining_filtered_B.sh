#!/bin/bash

# this is for dataset B
# this is to double entries with NAs and fill them in if it can - it ASSUMES THAT THE FILE HAS ALREADY ALL ENTRIES (VARIANTS) IN, BUT WHERE SOME/ALL OF THEM WILL HAVE
# NAs in the LD windows

trait=$1;
chrom=$2;
resfile="/lustre/scratch115/teams/anderson/ibd_conditional/UK_only_analysis_B_results/${trait}/results.${trait}.${chrom}.txt.filtered"

while read loci;
do
variants=($loci)  #### all i need is to make a file containing these information. I need to take the output from the
chr=${variants[0]}
pos=${variants[2]}
name=${variants[1]}
al1=${variants[3]}
al2=${variants[4]}
pval=${variants[5]}
end=$(($pos + 500000))
start=$(($pos - 500000))
if [ $start -le 0 ];then
start=0
fi

results=($(grep "$pos" "$resfile" | awk -v POS="$pos" '{if($3==POS){print $0;}}'))
window_left=${results[6]}
if [ "$window_left" == "NA" ]; then
echo "start: ${start} and  end: ${end} for variant ${name} at ${pos}"

/software/hgi/pkglocal/tabix-git-1ae158a/bin/tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chr}:${start}-${end}" > tabix.out."$trait"."${chr}"."${start}"."${end}".vcf
/software/hgi/pkglocal/plink-1.90b2f/bin/plink --vcf tabix.out."$trait"."${chr}"."${start}"."${end}".vcf --ld-window-kb 2000 --ld-window 999999 --ld-window-r2 0.6  --r2 --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink --threads 5  --out plink_ld.out."$trait"."${chr}"."${start}"."${end}"
grep "$pos" plink_ld.out."$trait"."${chr}"."${start}"."${end}".ld > plink_ld.out."$trait"."${chr}"."${start}"."${end}".ld.tmp

min1=$( cat plink_ld.out."$trait"."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {min = 300000000} {if ($2<min) min=$2} END {print min}')
min2=$( cat plink_ld.out."$trait"."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {min = 300000000} {if ($5<min) min=$5} END {print min}')
max1=$( cat plink_ld.out."$trait"."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {max = 0} {if ($2>max) max=$2} END {print max}')
max2=$( cat plink_ld.out."$trait"."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {max = 0} {if ($5>max) max=$5} END {print max}')
min=$(($min1<$min2?$min1:$min2))
max=$(($max1>$max2?$max1:$max2))
if [ $min -eq 300000000 ]; then
min=NA
fi
if [ $max -eq 0 ]; then
max=NA
fi

#now either overwrite that column or add to the end of the file
#replace
original_line=$(grep "$pos" "$resfile"|awk -v NAME="$name" -v POS="$pos" '{if( ($2==NAME) && ($3==POS) ){print $0;}}')

new_line="${chr} ${name} ${pos} ${al1} ${al2} ${pval} ${min} ${max}"
echo "original: ${original_line} and new: ${new_line}"
sed -i "s/$original_line/$new_line/"  "$resfile"

#remove vcf file and original plink ld file to save space
rm tabix.out."$trait"."${chr}"."${start}"."${end}".vcf
rm plink_ld.out."$trait"."${chr}"."${start}"."${end}".ld
rm plink_ld.out."$trait"."${chr}"."${start}"."${end}".nosex
rm plink_ld.out."$trait"."${chr}"."${start}"."${end}".log
rm plink_ld.out."$trait"."${chr}"."${start}"."${end}".ld.tmp
fi
done < $resfile

