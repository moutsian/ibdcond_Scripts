#!/bin/bash
trait=$1;
#trai"${y,,}"
chr=$2;
pos=$3;
#IIBDGC=($(grep "$pos" "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/UKIBDGC_meta_B/results/${trait,,}/${chr}-meta.txt"))
IIBDGC=($(grep "$pos" "/lustre/scratch113/projects/crohns/iibdgc_meta/data/IIBDGC/${trait,,}/${chr}.assoc"))
#/lustre/scratch113/projects/crohns/iibdgc_meta/data/IIBDGC/ibd/12.assoc 
GWAS3=($(grep "$pos" "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/GWAS3/${trait,,}/${chr}.assoc"))
IBDseq=($(grep "$pos" "/lustre/scratch113/projects/crohns/2015jan20/GWAS_imputation/assoc_NEW/IBDSeq/${trait,,}/${chr}.assoc"))
var=${IBDseq[1]}
frq=${IIBDGC[9]}
frq2=${GWAS3[30]}
frq3=${IBDseq[30]}
fGWAS3=$(echo "$frq2"| awk '{if ($1>0.5){$1=(1-$1);}{print $1;}}')
fIIBDGC=$(echo "$frq"| awk '{if ($1>0.5){$1=(1-$1);}{print $1;}}')
fIBDseq=$(echo "$frq3"| awk '{if ($1>0.5){$1=(1-$1);}{print $1;}}')

echo "${var}, MAF in IIBDGC: ${fIIBDGC}, GWAS3: ${fGWAS3}, IBDseq: ${fIBDseq}"

