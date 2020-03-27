#!/bin/bash

#Desc: displays ### bars and count when used in conjunction with Apache accesslog file and countem.sh
#Usage: less accesslog | ./countem.sh | ./histogram.sh -s
# -s: specifies maximum bar size, used for scaling

function pr_bar () {
	local -i i raw maxraw scaled
	raw=$1
	maxraw=$2
	((scaled=(MAXBAR*raw)/maxraw))

	((raw > 0 && scaled == 0)) && scaled=1

	for((i=0; i<scaled; i++))
	do
		printf '#'
	done
}

declare -A RA
declare -i MAXBAR max
max=0

if [[ $1 == '-s' ]]
then
	shift
	MAXBAR=$1
elif [[ $# > 0 ]]
then
	echo "Usage: less accesslog | ./countem.sh | ./histogram.sh -s specifies maximum bar size, used for scaling"
	exit
else
	MAXBAR=50
fi

while read labl val
do
	let RA[$labl]=$val

	((val>max)) && max=$val
done

for labl in "${!RA[@]}"
do
	printf '%-20.20s  ' "$labl"
	pr_bar ${RA[$labl]} $max
	printf "  ${RA[$labl]}"
	printf "\n"
done
