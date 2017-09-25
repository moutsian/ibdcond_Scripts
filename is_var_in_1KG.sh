#!/bin/bash

# this is to check if variants which don't have an LD window (window_left=NA) are in 1kg or not and if they are, what is their freq.

trait=$1;
chrom=$2;
resfile="/lustre/scratch115/teams/anderson/ibd_conditional/UK_only_analysis_B_results/${trait}/results.${trait}.${chrom}.txt"
outfile="/lustre/scratch115/teams/anderson/ibd_conditional/UK_only_analysis_B_results/${trait}/results.${trait}.${chrom}.txt.plus"
echo "CHR VARIANT POS AL1 AL2 PVAL LD_LEFT LD_RIGHT 1KG_CEU_GBR_FREQ" > "$outfile"
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
end=$(($pos))
start=$(($pos))
if [ $start -le 0 ];then
start=0
fi

echo "start: ${start} and  end: ${end} for variant ${name} at ${pos}"

/software/hgi/pkglocal/tabix-git-1ae158a/bin/tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chr}:${start}-${end}" > tabix.out."${chr}"."${start}"."${end}".vcf  
/software/hgi/pkglocal/plink-1.90b2f/bin/plink --vcf tabix.out."${chr}"."${start}"."${end}".vcf --freq --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink --threads 5  --out plink_freq.out."${chr}"."${start}"."${end}"

plinkfile=plink_freq.out."${chr}"."${start}"."${end}".frq
if [ -f  $plinkfile ]; then
MAF=$(sed -n '2,2p' "$plinkfile"|awk '{print $5 }')
new_line="${chr} ${name} ${pos} ${al1} ${al2} ${pval} ${wleft} ${wright} ${MAF}"
else
new_line="${chr} ${name} ${pos} ${al1} ${al2} ${pval} ${wleft} ${wright} not_in_1KG"
fi
echo "$new_line" >> "$outfile"

#remove vcf file and original plink ld file to save space
rm tabix.out."${chr}"."${start}"."${end}".vcf
rm plink_freq.out."${chr}"."${start}"."${end}".frq
rm plink_freq.out."${chr}"."${start}"."${end}".nosex
rm plink_freq.out."${chr}"."${start}"."${end}".log
done < $resfile

