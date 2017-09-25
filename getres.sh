#!/bin/bash
trait=$1;
for((i=1;i<=22;i++))
do
echo "i: ${i}"
cat "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/ALL/${trait}/${i}-meta.txt" |awk -v CHR="${i}" '{if($6<1e-05){$1=CHR; print $0;}}' > "/lustre/scratch115/teams/anderson/ibd_conditional/UK_only_analysis_B_results/${trait}/UK_only_analysis_B.${trait}.${i}.1e-05.txt"
done
