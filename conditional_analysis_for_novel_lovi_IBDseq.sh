
#!/bin/bash
assoc=$1
chr=$2
start=$3
end=$4
cond_snp=$5

#/nfs/team152/javi/ToolBox/snptest_v2.5_linux_x86_64_static/snptest_v2.5 \
#-data /lustre/scratch113/projects/crohns/RELEASE/v1/IBDseq/$chr.gen.gz /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/IBDSeq/refs/IBDSeq.${assoc}.sample \
#-o "/lustre/scratch115/teams/anderson/ibd_conditional/IBDseq.$chr.$start.${assoc}.uncond" \
#-frequentist 1 \
#-method score \
#-pheno bin1 \
#-cov_all_continuous \
#-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/IBDSeq/refs/samples_to_exclude.txt" \
#-range "$start"-"$end"

#conditional
/nfs/team152/javi/ToolBox/snptest_v2.5_linux_x86_64_static/snptest_v2.5 \
-data /lustre/scratch113/projects/crohns/RELEASE/v1/IBDseq/$chr.gen.gz /lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/IBDSeq/refs/IBDSeq.${assoc}.sample \
-o "/lustre/scratch115/teams/anderson/ibd_conditional/IBDseq.$chr.$start.${assoc}.cond_on.${cond_snp}.fast" \
-frequentist 1 \
-method score \
-pheno bin1 \
-cov_all_continuous \
-condition_on "${cond_snp}" \
-exclude_samples "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/IBDSeq/refs/samples_to_exclude.txt" \
-range "$start"-"$end"
