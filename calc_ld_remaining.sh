#!/bin/bash

trait=$1;
lociFile="/lustre/scratch115/teams/anderson/ibd_conditional/final_meta_analysis_C.${trait}.5e_08.remaining.txt"
echo "CHR VARIANT POS AL1 AL2 PVAL LD_LEFT LD_RIGHT" > /lustre/scratch115/teams/anderson/ibd_conditional/results.${trait}.remaining.txt

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
echo "start: ${start} and  end: ${end} for variant ${name} at ${pos}"
/software/hgi/pkglocal/tabix-git-1ae158a/bin/tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chr}:${start}-${end}" > tabix.out."${chr}"."${start}"."${end}".vcf
/software/hgi/pkglocal/plink-1.90b2f/bin/plink --vcf tabix.out."${chr}"."${start}"."${end}".vcf --ld-window-kb 2000 --ld-window 999999 --ld-window-r2 0.6  --r2 --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink --threads 5  --out plink_ld.out."${chr}"."${start}"."${end}"
grep "$pos" plink_ld.out."${chr}"."${start}"."${end}".ld > plink_ld.out."${chr}"."${start}"."${end}".ld.tmp

min1=$( cat plink_ld.out."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {min = 400000000} {if ($2<min) min=$2} END {print min}')
min2=$( cat plink_ld.out."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {min = 400000000} {if ($5<min) min=$5} END {print min}')
max1=$( cat plink_ld.out."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {max = 0} {if ($2>max) max=$2} END {print max}')
max2=$( cat plink_ld.out."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {max = 0} {if ($5>max) max=$5} END {print max}')
min=$(($min1<$min2?$min1:$min2))
max=$(($max1>$max2?$max1:$max2))
if [ $min -eq 400000000 ]; then
min=NA
fi
if [ $max -eq 0 ]; then
max=NA
fi

echo "${chr} ${name} ${pos} ${al1} ${al2} ${pval} ${min} ${max}">> /lustre/scratch115/teams/anderson/ibd_conditional/results.${trait}.remaining.txt

#remove vcf file and original plink ld file to save space
rm tabix.out."${chr}"."${start}"."${end}".vcf
rm plink_ld.out."${chr}"."${start}"."${end}".ld
rm plink_ld.out."${chr}"."${start}"."${end}".nosex
rm plink_ld.out."${chr}"."${start}"."${end}".log
rm plink_ld.out."${chr}"."${start}"."${end}".ld.tmp
done < $lociFile

