module add hgi/metal/latest

chr=$LSB_JOBINDEX
dir=$1

#Identify columns
echo "
MARKER	rsid
ALLELE	alleleA alleleB
EFFECT	frequentist_add_beta_1
STDERR	frequentist_add_se_1
PVAL	frequentist_add_pvalue

SCHEME STDERR

PROCESS $dir/GWAS1/cd/$chr.assoc
PROCESS $dir/GWAS3/cd/$chr.assoc
PROCESS $dir/IBDSeq/cd/$chr.assoc

OUTFILE $dir/UKIBDGC_meta_B/results/cd/$chr-meta_ .txt
ANALYZE HETEROGENEITY

QUIT" > $dir/UKIBDGC_meta_B/results/cd/$chr"-input.txt"

metal $dir/UKIBDGC_meta_B/results/cd/$chr"-input.txt"

mv $dir/UKIBDGC_meta_B/results/cd/$chr-meta_1.txt $dir/UKIBDGC_meta_B/results/cd/$chr-meta.txt

mkdir -p $dir/UKIBDGC_meta_B/results/cd'/metal_files/' 
mv $dir/UKIBDGC_meta_B/results/cd/$chr"-input.txt" $dir/UKIBDGC_meta_B/results/cd'/metal_files/' 
mv $dir/UKIBDGC_meta_B/results/cd/$chr-meta_1.txt.info $dir/UKIBDGC_meta_B/results/cd'/metal_files/' 
