#!/usr/bin/bash

lociFile="/nfs/users/nfs_l/lm12/IBD_conditional/step2.ALL.NOVEL.round2.with_info_on_previous_hits_from_5PAPERS.auto.with_corr_pvals.txt"
meta_dir="/lustre/scratch115/teams/anderson/ibd_conditional/meta_results"
lociFileout="/nfs/users/nfs_l/lm12/IBD_conditional/step2.ALL.NOVEL.round2.with_all_info.txt"
while read loci
do
	results=($loci)
	trait=${results[0]}
	chr=${results[1]}
	pos=${results[3]}
	startLoci=$(($pos - 5))
	endLoci=$(($pos + 5))


utrait=${trait^^} #upper case
ltrait=${trait,,} # lower case

uncond_value=$(grep "$pos" $meta_dir/$utrait.$chr.$pos.unconditional.meta |awk '{print $6;}')
cond_value=$(grep "$pos" $meta_dir/$utrait.$chr.$pos.meta |awk '{print $6;}')
#for i in ${results[*]}
#do
#echo -ne  "$i"'\t'
#done
#echo -e "${uncond_value}" '\t' "${cond_value}"
echo -e "$loci" '\t' "${uncond_value}" '\t' "${cond_value}"
done < $lociFile
