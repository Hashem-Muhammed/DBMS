#!/usr/bin/bash 
function deleteFromTable {
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
	

names=( $(awk -F: '{if(NR == 1){for (i=1; i<=NF; i++ ) print $i} }' $table_name) ) 
lines_number=( $(cat $table_name | wc -l) )
echo "What do you want to delete?"	
		select choice in delete_all delete_on_condition
			do
			case $choice in
			delete_all)
			lines="3,$lines_number";
			sed -i "$lines"'d' $table_name;
			break;;
			delete_on_condition) delete_eq
			break;;
			*) echo "$REPLY is not one of the choices"
			;;
			esac
			done
}
function delete_eq {
flag=0
index=0
i=0
echo "Enter the column name"
read column_name			
while true
do
for ele in ${names[@]}
	do
	if [[ $column_name == $ele ]]
		then	
			flag=1
			((index=i+1))
	fi
	((i+=1))
	done
if [[ $flag -eq 0 ]]
	then	
		echo "$column_name doesn't exist! please try again"
		echo "Enter the column name"
		read column_name
		continue;
	fi
	break;
done
echo "Enter the value"
read value
awk -F: -v val="$value" -v i="$index" ' NR<=2 || $i != val  ' $table_name > temp && mv temp $table_name

}

deleteFromTable
