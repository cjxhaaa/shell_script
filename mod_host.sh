#!/bin/sh

IFS=$'\n'

base_arrs=($(awk '{print}' /etc/hosts))

arrs=($(awk '/([0-9]{1,3}\.){3}[0-9]{1,3}.*#.*\[/ {print $1,$2}' $1))



function contains() {
	local IFS=" "
	local n=$#
	local value=${!n}
	local re='.*([0-9]{1,3}\.){3}[0-9]{1,3}.*'
	for ((i=1; i < n; i++)) {
		if [[ ${!i} =~ $re ]]; then
			local a=${!i}
			local b=$value
			local aa=($a)
			local bb=($b)
			if [[ ${aa[1]} == ${bb[1]} ]]; then
				echo $i
				return 0
			fi
		fi
	}
	echo "n"
	return 1
}

for i in "${!arrs[@]}"
do
	echo ${arrs[$i]}
	contain_condition=`contains ${base_arrs[@]} ${arrs[$i]}`

	if [ $contain_condition != "n" ]; then
        base_arrs[$contain_condition-1]=${arrs[$i]}
	else
		echo ${arrs[$i]}
		base_arrs[${#base_arrs[*]}]=${arrs[$i]}
	fi
done


printf "%s\n" "${base_arrs[@]}" > /etc/hosts
