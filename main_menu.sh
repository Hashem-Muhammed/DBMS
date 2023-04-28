#!/usr/bin/bash 
select choice in Create_Database List_Databases Connect_TO_Databases Drop_Databases 
do
	case $choice in 
		Create_Database)
			source ./creat_db.sh;
			exit
			;;
		List_Databases)
			cd ./databases/;
			ls -d */ ;
			cd ../
			exit
			;;
		Connect_TO_Databases)
			source ./connect_db.sh;
			exit
			;;
		Drop_Databases)
			source ./drop_db.sh;
			exit	
			;;				
		*)
			echo "please enter valid option"		
			;;	
	esac
done			
