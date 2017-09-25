
#!/bin/bash
assoc=$1
chr=$2
start=$3
end=$3
cond_snp="16:50763778_G_GC add 16:50756540_G_C add 16:50745926_C_T add"
cond_snp_nosp="$(echo -e "${cond_snp}" | tr -d '[[:space:]]')"
echo ${cond_snp_nosp}

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
-o "/lustre/scratch115/teams/anderson/ibd_conditional/GWAS1.$chr.$start.${assoc}.cond_on.${cond_snp_nosp}.fast" \
-frequentist 1 \
-method score \
-pheno bin1 \
-cov_all_continuous \
-condition_on "16:50763778_G_GC" "16:50756540_G_C" "16:50745926_C_T" \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS1/refs/GWAS1.cd.samples_to_exclude" \
-range "$start"-"$end"
