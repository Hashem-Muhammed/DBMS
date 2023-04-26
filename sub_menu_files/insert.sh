#!/usr/bin/bash
values=()
i=0
echo "Enter the table name:"
read table_name
while true
	do
		if ! [[ -f $table_name ]]
			then
			echo "There is no table with the same name! Please try again"
			echo "enter the name of the table"
			read table_name
			continue;
		fi
		break;
	done
#columns_numbers=`head -1 $table_name | awk -F: '{print NF}'`
names=( $(awk -F: '{if(NR == 1){for (i=1; i<=NF; i++ ) print $i} }' $table_name) ) 
types=( $(awk -F: '{if(NR == 2){for (i=1; i<=NF; i++ ) print $i} }' $table_name) ) 		
		
for name in ${names[@]}
do
echo "Enter the value for $name"
echo "It should be ${types[$i]}"
read value

if [ "${types[$i]}" = "str" ];
	then
		while true
			do
			if ! [[ $value =~ ^[a-zA-Z]+$ ]]
				then
				echo "Invalid value! It should be ${types[$i]}"
				read value
				continue;
			fi
			if [[ $i -eq 0 ]]
				then
				exist=( $(sed '1,2 d' $table_name | awk -F: '{print $1}'| 								grep $value) )
				if ! [[ -z "$exist" ]]
					then
					echo "There is a row with the same value! please try different one."
					read value
					continue;
				fi
			fi	
			values[$i]=$value
			break;	
			done
fi			
if [ "${types[$i]}" = "int" ];
	then
		while true
			do
			if ! [[ $value =~ [0-9] ]]
				then
				echo "Invalid value! It should be ${types[$i]}"
				read value
				continue;
			fi
			if [[ $i -eq 0 ]]
			echo "here"
				then
				exist=( $(sed '1,2 d' $table_name | awk -F: '{print $1}'| 								grep $value) )
				if ! [[ -z "$exist" ]]
					then
					echo "There is a row with the same value! please try different one."
					read value
					continue;
				fi
			fi
			values[$i]=$value
			break;
			done
fi			
((i+=1))
done

source ../../sub_menu_files/append.sh;
append $table_name ${values[@]} 
	
	
