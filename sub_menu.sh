#!/usr/bin/bash 
select choice in Create_Table List_Tables Insert_In_TO_Table Drop_Table Select_From_Table Delete_From_Table Update_Table
do
	case $choice in 
		Create_Table)
			source ../../sub_menu_files/create_table.sh ;
			exit
			;;
		List_Tables)
			ls -f
			cd ../../
			exit
			;;
		Insert_In_TO_Table)
			source ../../sub_menu_files/insert.sh  ;
			cd ../../
			exit
			;;
		Drop_Table)
			source ../../sub_menu_files/drop_table.sh  ;
			cd ../../
			exit	
			;;	
		Select_From_Table)
			source ../../sub_menu_files/select.sh  ;
			cd ../../
			exit	
			;;
		Delete_From_Table)
			source ../../sub_menu_files/delete.sh  ;
			cd ../../
			exit	
			;;
		Update_Table)
			source ../../sub_menu_files/update.sh  ;
			cd ../../
			exit	
			;;						
		*)
			echo "please enter valid option"		
			;;	
	esac
done
$SHELL			
