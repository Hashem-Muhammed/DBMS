#!/usr/bin/bash
function append
{	
	local i=1
	local str=""
	local table_n="$1"
	shift
	local ls=("$@")
	for ele in "${ls[@]}" 
		do
		if ! [[ $i -eq "${#ls[@]}" ]]
			then 
				str+=$ele
				str+=":"
				((i+=1))
				continue;
			fi
		str+=$ele
		#echo $str	
		((i+=1))
		done	
	echo $str  >> $table_n
		
}
