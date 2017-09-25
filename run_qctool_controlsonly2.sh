#!/bin/bash
log="/lustre/scratch115/teams/anderson/ibd_conditional/logs/"

i=$1 #chromosome
startpos=$2;
# 21/03: note that GWAS1,GWAS2,GWAS3 may need to be updated with the directories where the latest files are. I haven't done so yet.
#-excl-range 06:25000000-40000000
project="IBDseq"
bsub -q normal -J $i.$project.ibd -R"select[mem>3000] rusage[mem=3000]" -M3000 -o "$log"/$i.$project.ibd.out \
-e "$log"/$i.$project.ibd.err \
/nfs/team152/juliet/software/qctool_v1.4-linux-x86_64/./qctool -g /lustre/scratch113/projects/crohns/RELEASE/v1/"$project"/"$i".gen.gz \
-snp-stats /lustre/scratch115/teams/anderson/ibd_conditional/snp_qc/snp_stats."$project".ibd."$i".txt.rest \
-s /lustre/scratch113/projects/crohns/RELEASE/v1/"$project"/"$project".sample \
 -incl-samples /lustre/scratch113/projects/crohns/RELEASE/v1/IBDseq/IBDseq-controls.to.include.for.qctool -excl-range "0${i}:1-${startpos}" -assume-chromosome "0${i}"

