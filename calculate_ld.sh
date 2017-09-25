#!/bin/bash
chrom=$1
pos=$2
end=$(($pos + 1000000))
start=$(($pos - 1000000))
if [ $start -le 0 ];then
start=0
fi
echo "start: ${start} and  end: ${end}"
tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chrom}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chrom}:${start}-${end}" > tabix.out."${chrom}"."${start}"."${end}".vcf
#plink --vcf tabix.out."${chrom}"."${start}"."${end}".vcf --ld-window-kb 2000 --ld-window 999999 --ld-window-r2 0.1  --r2 --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink  --out plink_ld.out."${chrom}"."${start}"."${end}"
plink --vcf tabix.out."${chrom}"."${start}"."${end}".vcf --ld-window-kb 2000 --ld-window 999999 --ld-window-r2 0.6  --r2 --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu.samples.plink  --out plink_ld.out.ceu."${chrom}"."${start}"."${end}"
