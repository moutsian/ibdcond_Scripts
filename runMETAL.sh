module add hgi/metal/latest

chr=$1
file1=$2
file2=$3
file3=$4
#file4=$5
#for IBD you will need to add another file (dataset), but for UC and CD three are needed
#Identify columns
echo "
MARKER	rsid
ALLELE	alleleA alleleB
EFFECT	frequentist_add_beta_1
STDERR	frequentist_add_se_1
PVAL	frequentist_add_pvalue

SCHEME STDERR

PROCESS $file1
PROCESS $file2
PROCESS $file3
PROCESS $file4
OUTFILE meta_${chr}_${file3}.txt
ANALYZE HETEROGENEITY

QUIT" > ${chr}_${file3}_input.txt
metal ${chr}_${file3}_input.txt
mv METAANALYSIS1.TBL metal_$file3.txt

