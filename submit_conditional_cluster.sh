#!/bin/bash

#novel_loci="~lm12/IBD_conditional/step2.ALL.NOVEL.round2.with_info_on_previous_hits_from_5PAPERS.auto.with_corr_pvals.txt"
novel_loci="/nfs/users/nfs_l/lm12/IBD_conditional/step2.ALL.NOVEL.round2.with_info_on_previous_hits_from_5PAPERS.auto.with_corr_pvals.txt"
while read loci;
do
loci_formatted=($loci)
TRAIT=${loci_formatted[0]}
CHROM=${loci_formatted[1]}
MAIN=${loci_formatted[3]}
results_dir="/lustre/scratch115/teams/anderson/ibd_conditional/results_from_conditional"
log_dir="/lustre/scratch115/teams/anderson/ibd_conditional/logs"
echo "Trait: ${TRAIT} Chrom: ${CHROM} Main: ${MAIN}"
bsub -q normal -J "$TRAIT.$CHROM.$MAIN" -R"select[mem>3000] rusage[mem=3000]" -M3000 -o $results_dir/$TRAIT.$CHROM.$MAIN.out -e $log_dir/$TRAIT.$CHROM.$MAIN.err sh ~lm12/Scripts/run_snptest_for_conditional.sh  "${TRAIT}" "${CHROM}" "${MAIN}"

done < $novel_loci
