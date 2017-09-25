#!/bin/bash

#resfile="/nfs/users/nfs_l/lm12/IBD_conditional/gw_vars_unique_reported.toprepare.txt"
outfile="/nfs/users/nfs_l/lm12/IBD_conditional/gw_vars_unique_reported.additional.ellinghaus.withLD.txt"
resfile="/nfs/users/nfs_l/lm12/IBD_conditional/gw_vars_unique_reported.toprepare.additional.ellinghaus.txt"

while read loci;
do
results=($loci)  #### all i need is to make a file containing these information. I need to take the output from the
chr=${results[0]}
pos=${results[1]}
name=${results[2]}
end=$(($pos + 500000))
start=$(($pos - 500000))
if [ $start -le 0 ];then
start=0
fi

echo " start: ${start} and  end: ${end} for variant ${name} at ${pos}"

/software/hgi/pkglocal/tabix-git-1ae158a/bin/tabix -h /lustre/scratch115/resources/1000g/release/20130502/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz "${chr}:${start}-${end}" > tabix.out."${chr}"."${start}"."${end}".vcf
/software/hgi/pkglocal/plink-1.90b2f/bin/plink --vcf tabix.out."${chr}"."${start}"."${end}".vcf --ld-window-kb 2000 --ld-window 999999 --ld-window-r2 0.6  --r2 --keep /lustre/scratch115/teams/anderson/ibd_conditional/ceu_gbr.samples.plink --threads 5  --out plink_ld.out."${chr}"."${start}"."${end}" --silent
grep "$pos" plink_ld.out."${chr}"."${start}"."${end}".ld > plink_ld.out."${chr}"."${start}"."${end}".ld.tmp

min1=$( cat plink_ld.out."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {min = 300000000} {if ($2<min) min=$2} END {print min}')
min2=$( cat plink_ld.out."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {min = 300000000} {if ($5<min) min=$5} END {print min}')
max1=$( cat plink_ld.out."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {max = 0} {if ($2>max) max=$2} END {print max}')
max2=$( cat plink_ld.out."${chr}"."${start}"."${end}".ld.tmp | awk 'BEGIN {max = 0} {if ($5>max) max=$5} END {print max}')
min=$(($min1<$min2?$min1:$min2))
max=$(($max1>$max2?$max1:$max2))
if [ $min -eq 300000000 ]; then
min=NA
fi
if [ $max -eq 0 ]; then
max=NA
fi

#replace
original_line=$(grep "$name" "$resfile")
new_line="${chr} ${pos} ${name} ${min} ${max}"
echo "original: ${original_line} and new: ${new_line}"
echo "${new_line}" >> "$outfile"
#sed -i "s/$original_line/$new_line/" "/nfs/users/nfs_l/lm12/IBD_conditional/gw_vars_unique_reported.toprepare.txt"

#remove vcf file and original plink ld file to save space

rm tabix.out."${chr}"."${start}"."${end}".vcf
rm plink_ld.out."${chr}"."${start}"."${end}".ld
rm plink_ld.out."${chr}"."${start}"."${end}".nosex
rm plink_ld.out."${chr}"."${start}"."${end}".log
rm plink_ld.out."${chr}"."${start}"."${end}".ld.tmp
done < $resfile

