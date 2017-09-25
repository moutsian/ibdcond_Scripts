#!/bin/bash
chrom=$1
pos1=$2
pos2=$3
if [ "$pos2" -le "$pos1" ];then
tmp=$pos1
pos1=$pos2
pos2=$tmp
fi

echo "chrom: ${chrom} and positions ${pos1} , ${pos2}"
tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chrom}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chrom}:${pos1}-${pos1}" > tabix.out."${chrom}"."${pos1}"."${pos2}".vcf
tabix /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chrom}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chrom}:${pos2}-${pos2}" >> tabix.out."${chrom}"."${pos1}"."${pos2}".vcf
plink --vcf tabix.out."${chrom}"."${pos1}"."${pos2}".vcf --ld-window-kb 100000 --ld-window 99999999 --ld-window-r2 0  --r2 --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink  --out plink_ld.out."${chrom}"."${pos1}"."${pos2}"



#remove some of the output files
rm /lustre/scratch115/teams/anderson/ibd_conditional/tabix.out."${chrom}"."${pos1}"."${pos2}".vcf
rm /lustre/scratch115/teams/anderson/ibd_conditional/plink_ld.out."${chrom}"."${pos1}"."${pos2}".nosex
rm /lustre/scratch115/teams/anderson/ibd_conditional/plink_ld.out."${chrom}"."${pos1}"."${pos2}".log

