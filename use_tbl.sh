#!/bin/bash

clear

list_tables

if isDirEmpty "./Databases/$db_name"
then 
    echo "There is no Tables to be Used"
    echo
    echo "Press Enter to return"
    read
    clear
    return
fi



while true
do

    
    echo "Enter the name of the table: "
    read tbl_name

    if isEmpty $tbl_name
    then
        echo
        echo "You Must Enter Table Name !"
        echo
        continue

    fi


    if filExist $db_name $tbl_name;
    then
        
        break
    else
        clear
        echo
        echo "Table $tbl_name is not exist !" 
        echo
        read
        return
        
        
    fi
        
done


clear
while true
do
    
    echo
    echo "Table $tbl_name is Opened"
    echo
    echo
    echo "1) Insert Record"
    echo "2) Update Record"
    echo "3) Delete Record"
    echo "4) List All Records"
    echo "5) Exit Table"
    echo
    echo -ne "Enter your selection : "

    read choice

    case $choice in
        1 ) 
            . ./insert_record.sh
        ;;
        2 )
            . ./update_record.sh
        ;;
        3 )
            . ./delete_record.sh
        ;;
        
        4 )
            . ./list_records.sh
        ;;

        5 )
            clear
            echo
            echo "Exiting Table $tbl_name"
            echo
            return
        ;;
        
        *)
            clear
            echo
            echo "$choice is not valid option."
            echo
            
        ;;
    esac
done




