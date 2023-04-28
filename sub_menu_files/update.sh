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


awk -F: 'BEGIN{i=1;} {if(NR!=2&&NR!=1){print i,$0; i++;}}' ./$TABL
echo ""
echo "enter the PK you want to use in where condition"
read PK


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
				
				VAL_F=( $(awk -v PK=$PK -v col=$COL_N -F: '{if($1 == PK){print $col}}' ./$TABL))
				
				awk -v PK=$PK -F: '{if($1 == PK){print $0}}' ./$TABL | sed -i "s/$VAL_F/$VAL/g" ./$TABL 
			

				
				break;	
			fi	
			
		
	else 
		echo "this column does not exist enter valid chioce "
	fi
done		


