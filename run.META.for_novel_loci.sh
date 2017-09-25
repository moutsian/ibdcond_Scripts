#!/usr/bin/bash

lociFile="/nfs/users/nfs_l/lm12/IBD_conditional/step2.ALL.NOVEL.round2.with_info_on_previous_hits_from_5PAPERS.auto.with_corr_pvals.txt"
snptest_dir="/lustre/scratch115/teams/anderson/ibd_conditional"
#GWAS1.IBD.1.209970605.209970615.unconditional.assoc
#GWAS1.CD.3.53133144.53133154.assoc
meta_dir="/lustre/scratch115/teams/anderson/ibd_conditional/meta_results"

while read loci
do
	results=($loci)
	trait=${results[0]}
	chr=${results[1]}
	pos=${results[3]}
	startLoci=$(($pos - 5))
	endLoci=$(($pos + 5))


utrait=${trait^^} #upper case
ltrait=${trait,,} # lower case


#SNPTEST - conditional
GWAS1_file="${snptest_dir}/GWAS1.${utrait}.$chr.$startLoci.$endLoci.assoc"
GWAS2_file="${snptest_dir}/GWAS2.${utrait}.$chr.$startLoci.$endLoci.assoc"
GWAS3_file="${snptest_dir}/GWAS3.${utrait}.$chr.$startLoci.$endLoci.assoc"
IBDseq_file="${snptest_dir}/IBDseq.${utrait}.$chr.$startLoci.$endLoci.assoc"

#SNPTEST - unconditional
GWAS1_file_u="${snptest_dir}/GWAS1.${utrait}.$chr.$startLoci.$endLoci.unconditional.assoc"
GWAS2_file_u="${snptest_dir}/GWAS2.${utrait}.$chr.$startLoci.$endLoci.unconditional.assoc"
GWAS3_file_u="${snptest_dir}/GWAS3.${utrait}.$chr.$startLoci.$endLoci.unconditional.assoc"
IBDseq_file_u="${snptest_dir}/IBDseq.${utrait}.$chr.$startLoci.$endLoci.unconditional.assoc"

ls -lrt  "${IBDseq_file}"
ls -lrt  "${IBDseq_file_u}"


if [ "$ltrait" = "ibd" ]; then
/software/team152/meta --snptest --method 1 --cohort $GWAS1_file $GWAS2_file $GWAS3_file $IBDseq_file  --threshold 0.4 --output $meta_dir/$utrait.$chr.$pos.meta
/software/team152/meta --snptest --method 1 --cohort $GWAS1_file_u $GWAS2_file_u $GWAS3_file_u $IBDseq_file_u  --threshold 0.4 --output $meta_dir/$utrait.$chr.$pos.unconditional.meta

elif [ "$ltrait" = "cd" ]; then
/software/team152/meta --snptest --method 1 --cohort $GWAS1_file $GWAS3_file $IBDseq_file --threshold 0.4 --output $meta_dir/$utrait.$chr.$pos.meta
/software/team152/meta --snptest --method 1 --cohort $GWAS1_file_u $GWAS3_file_u $IBDseq_file_u --threshold 0.4 --output $meta_dir/$utrait.$chr.$pos.unconditional.meta

else
/software/team152/meta --snptest --method 1 --cohort  $GWAS2_file $GWAS3_file $IBDseq_file --threshold 0.4 --output $meta_dir/$utrait.$chr.$pos.meta
/software/team152/meta --snptest --method 1 --cohort  $GWAS2_file_u $GWAS3_file_u $IBDseq_file_u --threshold 0.4 --output $meta_dir/$utrait.$chr.$pos.unconditional.meta

fi

done < $lociFile
