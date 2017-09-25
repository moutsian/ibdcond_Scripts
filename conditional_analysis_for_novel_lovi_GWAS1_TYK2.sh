
#!/bin/bash
assoc=$1
chr=$2
start=$3
end=$3
cond_snp="19:10469975_A_Cadd19:10512911_G_Aadd"
echo ${cond_snp}

/nfs/team152/javi/ToolBox/snptest_v2.5_linux_x86_64_static/snptest_v2.5 \
-data /lustre/scratch113/projects/crohns/RELEASE/v1/GWAS1/$chr.gen.gz /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS1/refs/GWAS1.cd.sample \
-o "/lustre/scratch115/teams/anderson/ibd_conditional/GWAS1.$chr.$start.${assoc}.uncond" \
-frequentist 1 \
-method score \
-pheno bin1 \
-cov_all_continuous \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS1/refs/GWAS1.cd.samples_to_exclude" \
-range "$start"-"$end"

#conditional
/nfs/team152/javi/ToolBox/snptest_v2.5_linux_x86_64_static/snptest_v2.5 \
-data /lustre/scratch113/projects/crohns/RELEASE/v1/GWAS1/$chr.gen.gz /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS1/refs/GWAS1.cd.sample \
-o "/lustre/scratch115/teams/anderson/ibd_conditional/GWAS1.$chr.$start.${assoc}.cond_on.${cond_snp}.fast" \
-frequentist 1 \
-method score \
-pheno bin1 \
-cov_all_continuous \
-condition_on "19:10469975_A_C" "19:10512911_G_A" \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS1/refs/GWAS1.cd.samples_to_exclude" \
-range "$start"-"$end"
