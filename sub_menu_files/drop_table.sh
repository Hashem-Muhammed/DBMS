#!/usr/bin/bash 
ls 
echo "enter name of table you want to drop"
read DROP
while true
do
if [[ -f $DROP ]]
		then
			echo "are you sure you want to to remove this table permanently?"
			echo "y / n
			"
			read ANSWER
			if test $ANSWER = "y"
				then
					rm -r $DROP
					echo "$DROP table deleted succfully"
					cd ../../
					break;
			else 
				break;
			fi
		
else	
		echo "this table does not exist
		"
		echo "enter name of table you want to drop
		"
		read DROP
		continue;
fi
done
$SHELL
