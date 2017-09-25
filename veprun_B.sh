#!/bin/bash

perl /nfs/team152/variant_effect_predictor.pl \
 -i /lustre/scratch115/teams/anderson/ibd_conditional/UK_only_analysis_B_results/putatively_novel_variants_vep_format.txt  \
--format ensembl --fork 4 --pubmed  --maf_1kg  --pick --sift b --polyphen b --cache --dir_cache /nfs/team152/eva/cache_vep_75  \
--symbol --canonical --total_length --numbers --domains --protein \
-o /lustre/scratch115/teams/anderson/ibd_conditional/UK_only_analysis_B_results/putatively_novel_variants.vep.annotated --force_overwrite  --pick

perl /nfs/team152/variant_effect_predictor.pl \
 -i /lustre/scratch115/teams/anderson/ibd_conditional/UK_only_analysis_B_results/putatively_novel_variants_vep_format.txt  \
--format ensembl --fork 4   --pick --sift b --polyphen b  \
--symbol --canonical --total_length --numbers --domains --protein --pick --refseq --database \
-o /lustre/scratch115/teams/anderson/ibd_conditional/UK_only_analysis_B_results/putatively_novel_variants.vep.annotated.refseq --force_overwrite


