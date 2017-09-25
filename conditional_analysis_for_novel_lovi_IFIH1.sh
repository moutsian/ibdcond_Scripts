
#!/bin/bash
assoc=$1
chr=$2
start=$3
end=$3
cond_snp="2:163110536_A_G"
cond_snp_nosp="$(echo -e "${cond_snp}" | tr -d '[[:space:]]')"
echo ${cond_snp_nosp}

/nfs/team152/javi/ToolBox/snptest_v2.5_linux_x86_64_static/snptest_v2.5 \
-data /lustre/scratch113/projects/crohns/RELEASE/v1/GWAS3/$chr.gen.gz /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/refs/GWAS3.ibd.sample \
-o "/lustre/scratch115/teams/anderson/ibd_conditional/gwas3.$chr.$start.${assoc}.uncond" \
-frequentist 1 \
-method score \
-pheno bin1 \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/refs/gwas3-$assoc-assoc-sample-exclusion.txt" \
-cov_all_continuous \
-exclude_snps "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/info/GWAS3_new/$chr-fail.list" \
-range "$start"-"$end"

#conditional
/nfs/team152/javi/ToolBox/snptest_v2.5_linux_x86_64_static/snptest_v2.5 \
-data /lustre/scratch113/projects/crohns/RELEASE/v1/GWAS3/$chr.gen.gz /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/refs/GWAS3.ibd.sample \
-o "/lustre/scratch115/teams/anderson/ibd_conditional/gwas3.$chr.$start.${assoc}.cond_on.${cond_snp_nosp}.fast" \
-frequentist 1 \
-method score \
-pheno bin1 \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/refs/gwas3-${assoc}-assoc-sample-exclusion.txt" \
-cov_all_continuous \
-condition_on "2:163110536_A_G" \
-exclude_snps "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/info/GWAS3_new/$chr-fail.list" \
-range "$start"-"$end"
