#!/bin/bash
mydir="/lustre/scratch115/teams/anderson/ibd_conditional";
trait="UC"
for((chromo=1;chromo<=22;chromo++))
do
bsub -q normal -J "$chromo$trait" -R"select[mem>12000] rusage[mem=12000]" -M12000 -o "$mydir"/logs/C_"${trait^^}"."$chromo".rep.out -e "$mydir"/logs/C_"${trait^^}"."$chromo".rep.err  -n5  -R"span[hosts=1]" sh calc_ld_missing_datasetB.sh "$trait" "$chromo"
done

trait="CD"
for((chromo=1;chromo<=22;chromo++))
do
bsub -q normal -J "$chromo$trait" -R"select[mem>12000] rusage[mem=12000]" -M12000 -o "$mydir"/logs/C_"${trait^^}"."$chromo".rep.out -e "$mydir"/logs/C_"${trait^^}"."$chromo".rep.err  -n5  -R"span[hosts=1]" sh calc_ld_missing_datasetB.sh "$trait" "$chromo"
done

trait="IBD"
for((chromo=1;chromo<=22;chromo++))
do
bsub -q normal -J "$chromo$trait" -R"select[mem>12000] rusage[mem=12000]" -M12000 -o "$mydir"/logs/C_"${trait^^}"."$chromo".rep.out -e "$mydir"/logs/C_"${trait^^}"."$chromo".rep.err  -n5  -R"span[hosts=1]" sh calc_ld_missing_datasetB.sh "$trait" "$chromo"
done

