#!/bin/bash
chrom=$1
pos=$2
end=$(($pos + 750000))
start=$(($pos - 750000))
if [ $start -le 0 ];then
start=0
fi
echo "start: ${start} and  end: ${end}"
tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chrom}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chrom}:${start}-${end}" > tabix.out."${chrom}"."${start}"."${end}".vcf
plink --noweb --vcf tabix.out."${chrom}"."${start}"."${end}".vcf --ld-window-kb 2000 --ld-window 999999 --ld-window-r2 0.6  --r2 --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink  --out plink_ld.out."${chrom}"."${start}"."${end}"
grep "$pos" plink_ld.out."${chrom}"."${start}"."${end}".ld > plink_ld.out."${chrom}"."${start}"."${end}".ld.tmp 

min1=$( cat plink_ld.out."${chrom}"."${start}"."${end}".ld.tmp | awk 'BEGIN {min = 400000000} {if ($2<min) min=$2} END {print min}')
min2=$( cat plink_ld.out."${chrom}"."${start}"."${end}".ld.tmp | awk 'BEGIN {min = 400000000} {if ($5<min) min=$5} END {print min}')
max1=$( cat plink_ld.out."${chrom}"."${start}"."${end}".ld.tmp | awk 'BEGIN {max = 0} {if ($2>max) max=$2} END {print max}')
max2=$( cat plink_ld.out."${chrom}"."${start}"."${end}".ld.tmp | awk 'BEGIN {max = 0} {if ($5>max) max=$5} END {print max}')
echo "chr: ${chrom} pos: ${pos} min: $(($min1<$min2?$min1:$min2)), max: $(($max1>$max2?$max1:$max2))"

#remove vcf file and original plink ld file to save space
#rm tabix.out."${chrom}"."${start}"."${end}".vcf
#rm plink_ld.out."${chrom}"."${start}"."${end}".ld
rm plink_ld.out."${chrom}"."${start}"."${end}".nosex
rm plink_ld.out."${chrom}"."${start}"."${end}".log

