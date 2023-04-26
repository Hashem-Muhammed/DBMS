#!/usr/bin/bash 
ls


while true
do

echo "choose table you want to select from "
read TABLE 
if ! [[ -f $TABLE ]]
	then
		echo "this table does not exist"
		continue;
else
		break;		
fi
done


		
names=( $(awk -F: '{if(NR == 1){for (i=1; i<=NF; i++ ) print $i} }' ./$TABLE ))

echo "do you want to select *
"
read X

if test $X = "y"
	then
		awk -F: 'BEGIN{i=1;} {if(NR!=2&&NR!=1){print i,$0; i++;}}' ./$TABLE
		
else
		echo ""
		echo "do you want to select * where specific value?
		"
		read X
		
		if test $X = "y"
			then
				while true
				do
					
					echo ""
					echo ${names[*]}
					echo ""
					echo "choose column you want to equal the value to"
					read col
					
					
					i=0
					for ele in ${names[@]}
					do
						if test $col == $ele
						then
							i=1
						fi	
					done
					
					
					if test $i -gt 0
					then	
					echo ""
					echo "enter value"
					read VAL
					
					COL=( $(awk -v c=$col -F: '{if(NR==1){for(i=1; i<=NF; i++){if(c == $i){print i;}}}}' ./$TABLE))
					awk -v val=$VAL	-v col=$COL -F: '{if($col == val){print $0}}' ./$TABLE
					break;
					
					
					else
					echo "this column does not exist"
					fi
				done	
		else 
				echo ${names[*]}
				echo "enter number of tables you want to select"
				read NUM
				
				
							
								
		
		fi		

fi
