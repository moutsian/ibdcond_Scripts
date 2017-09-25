
#!/bin/bash
assoc=$1
chr=$2
start=$3
end=$4

#dominant
/software/team152/snptest_v2.5.2_linux_x86_64_dynamic/./snptest_v2.5.2 \
 -data /lustre/scratch113/projects/crohns/RELEASE/v1/GWAS3/$chr.gen.gz \
 /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/refs/GWAS3.ibd.sample \
-o "/lustre/scratch115/teams/anderson/ibd_conditional/gwas3.$chr.$start.recessive.uncond" \
-frequentist 3 \
-method score \
-pheno bin1 \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/refs/gwas3-$assoc-assoc-sample-exclusion.txt" \
-cov_all_continuous \
-exclude_snps "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/info/GWAS3_new/$chr-fail.list" \
-range "$start"-"$end"

