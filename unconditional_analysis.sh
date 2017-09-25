
#!/bin/bash
assoc=$1
chr=$2
start=$3
end=$3

#unconditional
/nfs/team152/javi/ToolBox/snptest_v2.5_linux_x86_64_static/snptest_v2.5 \
-data /lustre/scratch113/projects/crohns/RELEASE/v1/GWAS3/$chr.gen.gz /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/refs/GWAS3.ibd.sample \
-o "/lustre/scratch115/teams/anderson/ibd_conditional/gwas3.$chr.$start.uncond.ml.noPC" \
-frequentist 1 \
-method ml \
-pheno bin1 \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/refs/gwas3-$assoc-assoc-sample-exclusion.txt" \
-range "$start"-"$end"

