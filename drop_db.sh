#!/usr/bin/bash 
cd ./databases
ls
echo ""
echo "enter name of database you want to drop"
read DROP
while true
do
if [[ -d $DROP ]]
		then
			echo "are you sure you want to to remove this database permanently?"
			echo "y / n"
			read ANSWER
			if test $ANSWER = "y"
				then
					rm -r $DROP
					echo ""
					echo "$DROP database deleted succfully"
					break;
			else 
				break;
			fi
		
else	
		echo "this database does not exist"
		echo "enter name of database you want to drop"
		read DROP
		continue;
fi
done
cd ../
$SHELL	
