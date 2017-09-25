#!/bin/bash

# this is to check if variants which don't have an LD window (window_left=NA) are in 1kg or not and if they are, what is their freq and I2.
#Note that this currently works for dataset A as it is.

trait=$1;
chrom=$2;
pos=$3;
resfile="/lustre/scratch115/teams/anderson/ibd_conditional/datasetA/IBDseq.${trait}.1e-05.filtered.may.info0.8.txt"
variants=($(grep "$pos" "$resfile"|awk -v POS="$pos" '{if($3==POS){print $0;}}'))
#echo ${variants}
if [ -f $resfile ]; then

#variants=($loci)  #### all i need is to make a file containing these information. I need to take the output from the
chr=${variants[0]}
pos=${variants[2]}
name=${variants[1]}
al1=${variants[3]}
al2=${variants[4]}
pval=${variants[9]}
i2="NA"
end=$(($pos))
start=$(($pos))
if [ $start -le 0 ];then
start=0
fi

echo "chrom: ${chr}, start, end: ${start}-${end} "
/software/hgi/pkglocal/tabix-git-1ae158a/bin/tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chr}:${start}-${end}" > tabix.out."${chr}"."${start}"."${end}".vcf  
/software/hgi/pkglocal/plink-1.90b2f/bin/plink --silent --vcf tabix.out."${chr}"."${start}"."${end}".vcf --freq --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink --threads 5  --out plink_freq.out."${chr}"."${start}"."${end}"

plinkfile=plink_freq.out."${chr}"."${start}"."${end}".frq
if [ -f  $plinkfile ]; then
#MAF=$(sed -n '2,2p' "$plinkfile"|awk '{print $5 }')
MAF=$(grep -vE 'DEL|DUP' "$plinkfile" |sed -n '2,2p' |awk '{print $5 }')
new_line="${chr} ${name} ${pos} ${al1} ${al2} ${pval} ${MAF} ${i2}"
else
new_line="${chr} ${name} ${pos} ${al1} ${al2} ${pval} ${wleft} not_in_1KG ${i2}"
fi
echo "$new_line"
#remove vcf file and original plink ld file to save space
rm tabix.out."${chr}"."${start}"."${end}".vcf
rm plink_freq.out."${chr}"."${start}"."${end}".frq
rm plink_freq.out."${chr}"."${start}"."${end}".nosex
rm plink_freq.out."${chr}"."${start}"."${end}".log


else
echo "file does not exist."
fi

