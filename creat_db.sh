#!/usr/bin/bash 
echo "enter name of database"
read DB_NAME
cd ./databases;
while true 
do
	if ! [[ $DB_NAME =~ ^[a-zA-Z]+$ ]]  
		then
			echo "invalid database name"
			echo "enter name of database"
			read DB_NAME
			continue;

	fi	
	
	if [[ -d $DB_NAME ]]
		then
			echo "database already exists"
			echo "enter another name"
			read DB_NAME
			continue;
	fi
	
	mkdir $DB_NAME	
	echo $DB_NAME is created succfully 
	cd ../	
	break
done
$SHELL
