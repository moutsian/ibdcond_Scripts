#checks the QCsummaries file and outputs problematic columns

chr=$1
pos=$2

data=($(zgrep "$pos" /lustre/scratch114/projects/crohns/RELEASE/QCsummaries/"${chr}".txt.gz))
header=($(zcat /lustre/scratch114/projects/crohns/RELEASE/QCsummaries/22.txt.gz|head -n1))
echo "${data[0]} fails filters:"
for ((i=1;i<=14;i++))
do
if (( "${data[$i]}" == "0" )); then
printf "${header[$i]},"
fi
done
printf "\n"
