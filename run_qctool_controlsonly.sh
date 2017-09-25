#!/bin/bash
log="/lustre/scratch115/teams/anderson/ibd_conditional/logs/"


# 21/03: note that GWAS1,GWAS2,GWAS3 may need to be updated with the directories where the latest files are. I haven't done so yet.

project="IBDseq"
for((i=1;i<=22;i++))
do
bsub -q normal -J $i.$project.ibd -R"select[mem>3000] rusage[mem=3000]" -M3000 -o "$log"/$i.$project.ibd.out \
-e "$log"/$i.$project.ibd.err \
/nfs/team152/juliet/software/qctool_v1.4-linux-x86_64/./qctool -g /lustre/scratch113/projects/crohns/RELEASE/v1/"$project"/"$i".gen.gz \
-snp-stats /lustre/scratch115/teams/anderson/ibd_conditional/snp_qc/snp_stats."$project".ibd."$i".txt \
-s /lustre/scratch113/projects/crohns/RELEASE/v1/"$project"/"$project".sample \
 -incl-samples /lustre/scratch113/projects/crohns/RELEASE/v1/IBDseq/IBDseq-controls.to.include.for.qctool
done

#project="GWAS3"
#for((i=1;i<=22;i++))
#do
#bsub -q normal -J $i.$project.ibd -R"select[mem>3000] rusage[mem=3000]" -M3000 -o "$log"/$i.$project.ibd.out \
#-e "$log"/$i.$project.ibd.err \
#/nfs/team152/juliet/software/qctool_v1.4-linux-x86_64/./qctool -g /lustre/scratch113/projects/crohns/RELEASE/v2/"$project"/"$i".gen.gz \
#-snp-stats /lustre/scratch115/teams/anderson/ibd_conditional/snp_qc/snp_stats."$project".ibd."$i".txt \
#-s /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/"$project"_with_pcs.sample \
# -incl-samples /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/gwas3-cases.to.exclude.for.qctool
#done

#project="GWAS1";
#for((i=1;i<=22;i++))
#do
#bsub -q normal -J $i.$project.ibd -R"select[mem>3000] rusage[mem=3000]" -M3000 -o "$log"/$i.$project.ibd.out \
#-e "$log"/$i.$project.ibd.err \
#/nfs/team152/juliet/software/qctool_v1.4-linux-x86_64/./qctool -g /lustre/scratch113/projects/crohns/RELEASE/v2/"$project"/"$i".gen.gz \
#-snp-stats /lustre/scratch115/teams/anderson/ibd_conditional/snp_qc/snp_stats."$project".allsamples."$i".txt \
#-s /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/"$project"_with_pcs.sample \
# -incl-samples /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/gwas1-cases.to.exclude.for.qctool
#done

#project="GWAS2"
#for((i=1;i<=22;i++))
#do
#bsub -q normal -J $i.$project.ibd -R"select[mem>3000] rusage[mem=3000]" -M3000 -o "$log"/$i.$project.ibd.out \
#-e "$log"/$i.$project.ibd.err \
#/nfs/team152/juliet/software/qctool_v1.4-linux-x86_64/./qctool -g /lustre/scratch113/projects/crohns/RELEASE/v2/"$project"/"$i".gen.gz \
#-snp-stats /lustre/scratch115/teams/anderson/ibd_conditional/snp_qc/snp_stats."$project".allsamples."$i".txt \
#-s /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/"$project"_with_pcs.sample \
# -incl-samples /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc/gwas2-cases.to.exclude.for.qctool
#done
