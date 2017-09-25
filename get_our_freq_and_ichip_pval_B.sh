#!/bin/bash
trait=$1;
#trai"${y,,}"
chr=$2;
pos=$3;
#IIBDGC=($(grep "$pos" "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/UKIBDGC_meta_B/results/${trait,,}/${chr}-meta.txt"))
IIBDGC=($(grep "$pos" "/lustre/scratch113/projects/crohns/iibdgc_meta/data/IIBDGC/${trait,,}/${chr}.assoc"))
GWAS1=($(grep "$pos" "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS1/cd/${chr}.assoc" | awk -v CHR=${chr} '{if($1==CHR){print $0}}'))
GWAS2=($(grep "$pos" "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS2/uc/${chr}.assoc" | awk -v CHR=${chr} '{if($1==CHR){print $0}}'))
GWAS3=($(grep "$pos" "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/${trait,,}/${chr}.assoc" | awk -v CHR=${chr} '{if($1==CHR){print $0}}'))
IBDseq=($(grep "$pos" "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/IBDSeq/${trait,,}/${chr}.assoc" | awk -v CHR=${chr} '{if($1==CHR){print $0}}'))
#Ichip=($(grep "$pos" "/lustre/scratch113/projects/ichip/IBD/transethnic/TEAS_final/summary_stats/EUR.${trait^^}.ichip_only.MMM.assoc" | awk -v CHR=${chr} '{if($1==CHR){print $0}}'))
Ichip=($(grep "$pos" "/nfs/users/nfs_l/lm12/IBD_conditional/EUR.IBD.ichip_only.MMM.assoc.liftedover" | awk -v CHR=${chr} '{if($1==CHR){print $0}}'))
datC=($(grep "$pos" "/lustre/scratch113/projects/crohns/iibdgc_meta/results/${trait,,}/${chr}-meta.filtered.LM.txt" | awk -v CHR=${chr} 'split($1,arr,":");{if(arr[1]==CHR){print $0}}'))
var=${IBDseq[1]}
frq0=${GWAS1[30]}
frq1=${GWAS2[30]}
frq2=${GWAS3[30]}
frq3=${IBDseq[30]}
pval_ichip=${Ichip[8]}
pval_IIBDGC=${IIBDGC[5]}
pval_datC=${datC[5]}
fGWAS1=$(echo "$frq0"| awk '{if ($1>0.5){$1=(1-$1);}{print $1;}}')
fGWAS2=$(echo "$frq1"| awk '{if ($1>0.5){$1=(1-$1);}{print $1;}}')
fGWAS3=$(echo "$frq2"| awk '{if ($1>0.5){$1=(1-$1);}{print $1;}}')
fIBDseq=$(echo "$frq3"| awk '{if ($1>0.5){$1=(1-$1);}{print $1;}}')

echo "${var}, MAF in GWAS1: ${fGWAS1}, MAF in GWAS2: ${fGWAS2}, GWAS3: ${fGWAS3}, IBDseq: ${fIBDseq}, pvalIchip:${pval_ichip}, pvalIIBDGC:${pval_IIBDGC}, pvalC:${pval_datC}"

