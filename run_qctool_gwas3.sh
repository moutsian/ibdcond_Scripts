#!/bin/bash
project=$1;
log="/lustre/scratch115/teams/anderson/ibd_conditional/logs/"

#for((i=5;i<=22;i++))
#do
#bsub -q normal -J $i.$project.ibd -R"select[mem>3000] rusage[mem=3000]" -M3000 -o "$log"/$i.$project.ibd.out \
#-e "$log"/$i.$project.ibd.err \
#/nfs/team152/juliet/software/qctool_v1.4-linux-x86_64/./qctool -g /lustre/scratch113/projects/crohns/RELEASE/v2/"$project"/"$i".gen.gz \
#-snp-stats /lustre/scratch115/teams/anderson/ibd_conditional/snp_qc/snp_stats."$project".ibd."$i".txt \
#-s /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/"$project"_with_pcs.sample
#done

for((i=1;i<=22;i++))
do
bsub -q normal -J $i.$project.uc -R"select[mem>3000] rusage[mem=3000]" -M3000 -o "$log"/$i.$project.uc.out \
-e "$log"/$i.$project.uc.err \
/nfs/team152/juliet/software/qctool_v1.4-linux-x86_64/./qctool -g /lustre/scratch113/projects/crohns/RELEASE/v2/"$project"/"$i".gen.gz \
-snp-stats /lustre/scratch115/teams/anderson/ibd_conditional/snp_qc/snp_stats."$project".uc."$i".txt \
-s /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/"$project"_with_pcs.sample \
-excl-samples /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/gwas3-uc-assoc-sample-exclusion.txt.forqctool
done

for((i=1;i<=22;i++))
do
bsub -q normal -J "$i.$project.cd" -R"select[mem>3000] rusage[mem=3000]" -M3000 -o "$log"/$i.$project.cd.out \
-e "$log"/"$i.$project.cd.err" \
/nfs/team152/juliet/software/qctool_v1.4-linux-x86_64/./qctool -g /lustre/scratch113/projects/crohns/RELEASE/v2/"$project"/"$i".gen.gz \
-snp-stats /lustre/scratch115/teams/anderson/ibd_conditional/snp_qc/snp_stats."$project".cd."$i".txt \
-s /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/"$project"_with_pcs.sample \
-excl-samples /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/gwas3-cd-assoc-sample-exclusion.txt.forqctool
done

