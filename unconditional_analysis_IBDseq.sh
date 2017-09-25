
#!/bin/bash
assoc=$1
chr=$2
start=$3
end=$4

#conditional
/software/team152/snptest_v2.5.2_linux_x86_64_dynamic/./snptest_v2.5.2 -data /lustre/scratch113/projects/crohns/RELEASE/v1/IBDseq/$chr.gen.gz /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/IBDSeq/refs/IBDSeq.${assoc}.sample \
-o "/lustre/scratch115/teams/anderson/ibd_conditional/IBDseq.$chr.$start.dominant.uncond" \
-frequentist 2 \
-method score \
-pheno bin1 \
-cov_all_continuous \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/IBDSeq/refs/samples_to_exclude.txt" \
-range "$start"-"$end"
