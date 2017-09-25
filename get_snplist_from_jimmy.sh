#!/bin/bash

FILE="/nfs/users/nfs_l/lm12/IBD_conditional/jimmyvars.txt"
while read -r entry
do
chrom=$(echo "$entry"|awk '{print $1}')
pos=$(echo "$entry"|awk '{print $2}')

echo "$chrom,$pos"
tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chrom}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chrom}:${pos}-${pos}" > tabix.out."${chrom}"."${pos}"."${pos}".vcf
grep -v '#' tabix.out."${chrom}"."${pos}"."${pos}".vcf|cut -f -10 >> jimmylist_1KG.txt
rm  tabix.out."${chrom}"."${pos}"."${pos}".vcf
done < "$FILE"
