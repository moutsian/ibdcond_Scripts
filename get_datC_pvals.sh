#!/bin/bash
#chr=$1;
#pos=$2;

lociFile="/nfs/users/nfs_l/lm12/IBD_conditional/table_of_ALL_loci_incl_all_Jimmy_SNPs_May18.txt"
while read loci
do
results=($loci)
chr=${results[0]}
pos=${results[2]}

pUC=$(grep ":${pos}_" /lustre/scratch113/projects/crohns/iibdgc_meta/results/uc/${chr}-meta.txt|awk '{print $6}')
pCD=$(grep ":${pos}_" /lustre/scratch113/projects/crohns/iibdgc_meta/results/cd/${chr}-meta.txt|awk '{print $6}')
pIBD=$(grep ":${pos}_" /lustre/scratch113/projects/crohns/iibdgc_meta/results/ibd/${chr}-meta.txt|awk '{print $6}')
printf "$chr,$pos,$pCD,$pUC,$pIBD\n" 
done < $lociFile
