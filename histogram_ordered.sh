#!/bin/bash

function pr_bar () {
	local -i i raw maxraw scaled
	raw=$1
	maxraw=$2
	((scaled=(maxbar*raw)/maxraw))

	((raw > 0 && scaled == 0)) && scaled=1

	for((i=0; i<scaled;i++))
	do
		printf '#'
	done
	printf '\n'

}

declare -a RA_key RA_val
declare -i max ndx
max=0
maxbar=50

ndx=0
while read labl val
do
	RA_key[$ndx]=$labl
	RA_value[$ndx]=$val

	((val > max)) && max=$val
	let ndx++
done

for((j=0; j<ndx; j++))
do
	printf "%-20.20s  " ${RA_key[$j]}
	pr_bar ${RA_value[$j]} $max
done
