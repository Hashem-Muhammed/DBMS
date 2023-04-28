#!/usr/bin/bash 

ls

while true
do
	echo ""
	echo "choose table you want to update in to "
	read TABL 
	if ! [[ -f $TABL ]]
		then
			echo "this table does not exist"
			continue;
	else
			break;		
	fi
done

names=( $(awk -F: '{if(NR == 1){for (i=1; i<=NF; i++ ) print $i} }' ./$TABL ))

while true
do
	echo ${names[@]}
	echo ""
	echo "enter the coloumn you want to use in where condition"
	read W_COL
	if true
		then
			i=0
			for ele in ${names[@]}
			do
				if test $W_COL == $ele
				then
					i=1
				fi	
			done
			
			
			if test $i -gt 0
			then
				echo "enter the value "
				read W_VAL
				W_COL_N=( $(awk -v c=$W_COL -F: '{if(NR==1){for(i=1; i<=NF; i++){if(c == $i){print i;}}}}' ./$TABL)) 
				echo $W_COL_N
				echo $W_VAL
				break;	
				
			fi	
			
		
	else 
		echo "this column does not exist enter valid chioce "
	fi
done		



while true
do
	echo ${names[@]}
	echo ""
	echo "enter the coloumn you want to set"
	read COL
	if true
		then
			i=0
			for ele in ${names[@]}
			do
				if test $COL == $ele
				then
					i=1
				fi	
			done
			
			
			if test $i -gt 0
			then
				echo "enter the value"
				read VAL
				COL_N=( $(awk -v c=$COL -F: '{if(NR==1){for(i=1; i<=NF; i++){if(c == $i){print i;}}}}' ./$TABL))
				
				VAL_F=( $(awk -v col=$COL_N -F: '{print $col}' ./$TABL))
				echo $COL_N
				echo $VAL_F
			awk -v W_COL=$W_COL_N -v W_VAL=$W_VAL -v VAL=$VAL -v COL=$COL_N -F: '{if($W_COL == W_VAL){print $0}}' ./$TABL | sed -i "s/011/$VAL/g" ./$TABL

				
				break;	
			fi	
			
		
	else 
		echo "this column does not exist enter valid chioce "
	fi
done		


