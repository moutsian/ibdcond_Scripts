#!/bin/bash

fmdir="/lustre/scratch113/projects/crohns/iibdgc_meta/results/finemap"

#for all CSQ.confset files
#for entry in "$fmdir"/*CSQ.confset
for entry in "$fmdir"/16_81922813_CSQ.confset
do
snp=$(echo "$entry"|awk '{split($1,arr,"/");print arr[9]}')
chr=$(echo ${snp}|awk '{split($1,arr,"_");print(arr[1])}')
pos=$(echo ${snp}|awk '{split($1,arr,"_");print(arr[2])}')
end=$(($pos + 750000))
start=$(($pos - 750000))
if [ $start -le 0 ];then
start=0
fi

max=$( grep -v "CUMSUM" $entry | awk 'BEGIN {maxi = 1} {if ($6>maxi&&$6!="NA") maxi=$6} END {print maxi}')
min=$( grep -v "CUMSUM" $entry | awk 'BEGIN {min = 300000000} {if ($6<min) min=$6} END {print min}')

#now check the LD window (r2 of 0.8) :
ldwin=($(sh calc_ld_v2.sh ${chr} ${pos} 750000 0.8|grep "min"))
tmp=$(echo "${ldwin[5]}" | awk '{split($1,arr,",");{print arr[1]}}')

echo "MAIN VARIANT: ${chr} ${pos}"
echo "fine-mapping window: [${min},${max}], ld-window (r2>=0.8):[${ldwin[5]}${ldwin[7]}]"
if(($tmp<${min} | ${ldwin[7]}>${max} ));then
	if (( $tmp<${min} ));then
		echo "LD window extends to the left of the finemapping window. Look for low info variants in ${tmp} ${min}"
		cat "plink_ld.out.${chr}.${start}.${end}.ld.tmp" | awk -v MIN="${min}" '{if($2<MIN || $5<MIN){print $0;}}'
		vars=($(cat "plink_ld.out.${chr}.${start}.${end}.ld.tmp" | awk -v MIN="${min}" '{if($2<MIN || $5<MIN){print $0;}}' | awk '{print $2}'))
	else
		echo "LD window extends to the right of the finemapping window. Look for low info variants in ${max} ${ldwin[7]}}"
		cat "plink_ld.out.${chr}.${start}.${end}.ld.tmp" | awk -v MAX="${max}" '{if($2>MAX || $5>MAX){print $0;}}'
		vars=($(cat "plink_ld.out.${chr}.${start}.${end}.ld.tmp" | awk -v MAX="${max}" '{if($2>MAX || $5>MAX){print $0;}}' | awk '{print $5}'))
	fi

	for i in ${vars[*]}
        do
        zgrep "$i"  /lustre/scratch114/projects/crohns/RELEASE/QCsummaries/"$chr".txt.gz|awk '{print "QC_summary:"$0;}'
	#grep ":${pos}_" /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/*/*/${chr}.assoc | awk '{split($1,arr,"/");{print "INFO "arr[9]" "arr[10]" "$2," "$43}}'
	grep ":${i}" /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/*/*/${chr}.assoc | awk '{split($1,arr,"/");{print "INFO "arr[9]" "arr[10]" "$2," "$43}}'
	grep  "$i" /lustre/scratch113/projects/crohns/iibdgc_meta/results/*/${chr}-meta.txt |awk '{split($1,arr,"/");split(arr[9],var,"txt:");$1=arr[8];print "METAL:"var[2]" "$0;}'
	done
else
echo "LD window fully covered by finemapping. No Action required."
rm plink_ld.out.${chr}.${start}.${end}.ld.tmp
fi

rm tabix.out.${chr}.${start}.${end}.vcf
#rm plink_ld.out.${chr}.${start}.${end}.log
#rm plink_ld.out.${chr}.${start}.${end}.nosex
rm plink_ld.out.${chr}.${start}.${end}.ld
echo -e "\n\n"
done
