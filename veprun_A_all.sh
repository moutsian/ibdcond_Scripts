#!/bin/bash
trait=$1;
perl /nfs/team152/variant_effect_predictor.pl \
 -i /lustre/scratch115/teams/anderson/ibd_conditional/datasetA/IBDseq."${trait}".1e-05.filtered.txt.vep_format.txt  \
--format ensembl --fork 4 --pubmed  --maf_1kg  --pick --sift b --polyphen b --cache --dir_cache /nfs/team152/eva/cache_vep_75  \
--symbol --canonical --total_length --numbers --domains --protein \
-o /lustre/scratch115/teams/anderson/ibd_conditional/datasetA/IBDseq."${trait}".1e_05.filtered.vep.annotated --force_overwrite  --pick

perl /nfs/team152/variant_effect_predictor.pl \
 -i /lustre/scratch115/teams/anderson/ibd_conditional/datasetA/IBDseq."${trait}".1e-05.filtered.txt.vep_format.txt  \
--format ensembl --fork 4   --pick --sift b --polyphen b  \
--symbol --canonical --total_length --numbers --domains --protein --pick --refseq --database \
-o /lustre/scratch115/teams/anderson/ibd_conditional/datasetA/IBDseq."${trait}".1e_05.filtered.vep.annotated.refseq --force_overwrite


