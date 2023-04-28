#!/usr/bin/bash 

ls
#enter the table name you want to update into then validate the table name 
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
#array of names of fields
names=( $(awk -F: '{if(NR == 1){for (i=1; i<=NF; i++ ) print $i} }' ./$TABL ))
types=( $(awk -F: '{if(NR == 2){for (i=1; i<=NF; i++ ) print $i} }' $TABL) ) 		
echo "${types[@]}"
while true
do
	echo ""
	echo ${names[@]}
	# print the database
	awk -F: 'BEGIN{i=1;} {if(NR!=2&&NR!=1){print $0; i++;}}' ./$TABL
	echo ""
	#take the column of the where and validate it
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
			# if the column is valid take value of where
				
				#retrive feild number of the where column
				W_COL_N=( $(awk -v c=$W_COL -F: '{if(NR==1){for(i=1; i<=NF; i++){if(c == $i){print i;}}}}' ./$TABL)) 
				echo "enter the value "
				read W_VAL				
				break;	

			fi	


	else 
		echo "this column does not exist enter valid chioce "
	fi
done		


#validate set column 
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
				#retrive the field number of set column 
				COL_N=( $(awk -v c=$COL -F: '{if(NR==1){for(i=1; i<=NF; i++){if(c == $i){print i;}}}}' ./$TABL))
				((index=$COL_N - 1))
				echo "enter the value it should be ${types[$index]}"
				read VAL
				
				
	
				
				
				if [ "${types[$index]}" = "str" ];
	then
		while true
			do
			if ! [[ $VAL =~ ^[a-zA-Z]+$ ]]
				then
				echo "Invalid value! It should be ${types[$index]}"
				read VAL
				continue;
			fi
			if [[ $index -eq 0 ]]
				then
				exist=( $(sed '1,2 d' $TABL | awk -F: '{print $1}'| 								grep $VAL) )
				if ! [[ -z "$exist" ]]
					then
					echo "There is a row with the same value! please try different one."
					read VAL
					continue;
				fi
			fi	
			break;	
			done
fi			
if [ "${types[$index]}" = "int" ];
	then
		while true
			do
			if ! [[ $VAL =~ [0-9] ]]
				then
				echo "Invalid value! It should be ${types[$index]}"
				read VAL
				continue;
			fi
			if [[ $index -eq 0 ]]
				then
				exist=( $(sed '1,2 d' $TABL | awk -F: '{print $1}'| 								grep $VAL) )
				if ! [[ -z "$exist" ]]
					then
					echo "There is a row with the same value! please try different one."
					read VAL
					continue;
				fi
			fi
			break;
			done
fi

				
			
				#retrive an array of current value/values of the set column 
				VAL_F=( $(awk -v W_COL=$W_COL_N -v W_VAL=$W_VAL -v VAL=$VAL -v COL=$COL_N -F: '{if($W_COL == W_VAL){print $COL}}' ./$TABL))
				if ! [[ ${#VAL_F[@]} -gt 1 && $index -eq 0 ]]
					then
					
				
#pass to the sed command the records that meet the where condtion then using sed to replace all values in VAL_F array with the value user entered
				awk -v W_COL=$W_COL_N -v W_VAL=$W_VAL -v VAL=$VAL -v COL=$COL_N -F: 'BEGIN{OFS=":"} {if($W_COL == W_VAL){$COL=VAL}}1' ./$TABL > temp && mv temp $TABL
				
				
				
				
				
				echo ""
				echo "Table updated successfully"
				echo ""
				awk -F: 'BEGIN{i=1;} {if(NR!=2&&NR!=1){print $0; i++;}}' ./$TABL
				echo ""	
				cd ../../
				break;	
			fi	
		
	echo " You are trying to update the primary key with the same value in many rows!"
	break;
	fi

	else 
		echo "this column does not exist enter valid chioce "
	fi
	
done	
