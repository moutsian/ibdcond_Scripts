#!/bin/bash
project=$1;
for((i=1;i<=22;i++))
do
/nfs/team152/juliet/software/qctool_v1.4-linux-x86_64/./qctool -g /lustre/scratch113/projects/crohns/RELEASE/v2/"$project"/"$i".gen.gz \
-snp-stats /lustre/scratch115/teams/anderson/ibd_conditional/snp_qc/snp_stats."$project".allsamples."$i".txt \
-s /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/"$project"_with_pcs.sample
done
