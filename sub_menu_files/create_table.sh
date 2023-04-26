#!/usr/bin/bash
names=()
types=()
function create_table 
{
echo "enter the name of the table"
read table_name
while true
	do
		if ! [[ $table_name =~ ^[a-zA-Z]+$ ]]
			then
			echo "Invalid table name"
			echo "enter the name of the table"
			read table_name
			continue;
		fi
		if [[ -f $table_name ]]
			then
			echo "There is a table with the same name!"
			echo "enter the name of the table"
			read table_name
			continue;
		fi
		touch $table_name
		break;
	done
select_columns_numbers
}
function select_columns_numbers
{
echo "Enter the number of the columns including the primary key"
read column_numbers
while true
	do
		if ! [[ $column_numbers =~ [0-9] ]]
			then
			echo "Invalid number!"
			echo "Enter the number of the columns including the primary key"
			read column_numbers
			continue;
		fi
		break;
	done
((i=0))
while [ $i -lt $column_numbers ]
	do
		if [[ $i -eq 0 ]]
			then
			echo "Enter the primary key name:"
			fi
		echo "Field $i name :"	
		read f_name
		while true
			do
			if ! [[ $f_name =~ ^[a-zA-Z]+$ ]]
				then
				echo "Invalid name"
				echo "Field $i name :"
				read f_name
				continue;
			fi
			names[$i]=$f_name
			break;
			done
		echo "Choose the datatype for field $i"	
		select choice in int str
			do
			case $choice in
			int) types[$i]="int"
			break;;
			str) types[$i]="str"
			break;;
			*) echo "$REPLY is not one of the choices"
			;;
			esac
			done
		((i+=1))
	done		
append $table_name ${names[@]}
append $table_name ${types[@]}		

}	

create_table
