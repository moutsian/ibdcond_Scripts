#!/bin/bash

# this is to check if variants which don't have an LD window (window_left=NA) are in 1kg or not and if they are, what is their freq.

chrom=$1;
pos=$2;
chr=$1;
start=$2;
end=$2;
/software/hgi/pkglocal/tabix-git-1ae158a/bin/tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chr}:${start}-${end}" > tabix.out."${chr}"."${pos}".vcf  
/software/hgi/pkglocal/plink-1.90b2f/bin/plink --vcf tabix.out."${chr}"."${pos}".vcf --freq --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink --threads 5  --out plink_freq.out."${chr}"."${pos}"

plinkfile=plink_freq.out."${chr}"."${pos}".frq
if [ -f  $plinkfile ]; then
MAF=$(grep -v "DUP" "$plinkfile" |sed -n '2,2p' |awk '{print $5 }')
new_line="${chr} ${name} ${pos} ${al1} ${al2} ${pval} ${wleft} ${wright} ${MAF}"
echo "$new_line" 
else
new_line="${chr} ${name} ${pos} ${al1} ${al2} ${pval} ${wleft} ${wright} not_in_1KG"
echo "$new_line"
fi
#remove vcf file and original plink ld file to save space
rm tabix.out."${chr}"."${pos}".vcf
#rm plink_freq.out."${chr}"."${pos}".frq
rm plink_freq.out."${chr}"."${pos}".nosex
rm plink_freq.out."${chr}"."${pos}".log

