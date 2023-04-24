#!/usr/bin/bash 
cd ./databases
ls -d */
echo "choose the database you want to connect to"
read CONNECT
while true
do
if [[ -d $CONNECT ]]
		then
			cd $CONNECT
			echo "you connected succefully to $CONNECT database"
			source ../../sub_menu.sh
			break;
		
else	
		echo "this database does not exist"
		echo "choose the database you want to connect to from above databases"
		read CONNECT
		continue;
fi
done
$SHELL	
