#!/bin/bash
perl /nfs/team152/variant_effect_predictor.pl \
 -i ~lm12/IBD_conditional/UK_only_analysis_B.IBD.1e_05.filtered.lowfreq.txt.ensembl \
--format ensembl --fork 4   --pick --sift b --polyphen b  \
--symbol --canonical --total_length --numbers --domains --protein --pick --refseq --database \
-o ~lm12/IBD_conditional/UK_only_analysis_B.IBD.1e_05.filtered.lowfreq.txt.annotated.refseq --force_overwrite


perl /nfs/team152/variant_effect_predictor.pl \
 -i ~lm12/IBD_conditional/UK_only_analysis_B.IBD.1e_05.filtered.lowfreq.txt.ensembl \
--format ensembl --fork 4 --pubmed  --maf_1kg  --pick --sift b --polyphen b --cache --dir_cache /nfs/team152/eva/cache_vep_75  \
--symbol --canonical --total_length --numbers --domains --protein --pick \
-o ~lm12/IBD_conditional/UK_only_analysis_B.IBD.1e_05.filtered.lowfreq.txt.annotated --force_overwrite


