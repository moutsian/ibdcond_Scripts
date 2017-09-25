
#!/bin/bash
assoc=$1
chr=$2
start=$3
end=$4

#conditional
/software/team152/snptest_v2.5.2_linux_x86_64_dynamic/./snptest_v2.5.2 -data /lustre/scratch113/projects/crohns/RELEASE/v1/GWAS1/$chr.gen.gz /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS1/refs/GWAS1.cd.sample \
-o "/lustre/scratch115/teams/anderson/ibd_conditional/GWAS1.$chr.$start.dominant.uncond" \
-frequentist 2 \
-method score \
-pheno bin1 \
-cov_all_continuous \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS1/refs/GWAS1.cd.samples_to_exclude" \
-range "$start"-"$end"
