#!/bin/bash
trait=$1;
#chromo=$2;
mydir="/lustre/scratch115/teams/anderson/ibd_conditional";
for((chromo=1;chromo<=22;chromo++))
do
bsub -q normal -J Rep"$chromo" -R"select[mem>12000] rusage[mem=12000]" -M12000 -o "$mydir"/logs/A"${trait}"."$chromo".filt.out -e "$mydir"/logs/A"$trait"."$chromo".filt.err -n5 -R"span[hosts=1]" sh calc_ld_missing_datasetA.sh "$trait" "$chromo"
done
