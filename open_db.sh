#!/bin/bash

clear

list_dbs

if isDirEmpty "./Databases/"
then 
    echo "There is no Databases to be Opened"
    echo
    echo "Press Enter to return"
    read
    clear
    return
fi


while true
do

    
    echo "Enter the name of the database: "
    read db_name

    if isEmpty $db_name
    then
        echo
        echo "You Must Enter DB Name !"
        echo
        continue

    fi


    if dirExist $db_name;
    then
        echo
        echo "DB $db_name is already exist !" 
        echo
        break
    else
        clear
        echo
        echo "DB $db_name is not exist !" 
        echo
        read
        return
        
        
    fi
        
done



while true
do
    clear
    echo
    echo "$db_name DB is Opened"
    echo
    echo "Tables"
    echo
    echo "1) Create Table"
    echo "2) Delete Table"
    echo "3) Use a Specific Table"
    echo "4) List Tables"
    echo "5) Exit DB"
    echo
    echo -ne "Enter your selection : "

    read choice

    case $choice in
        1 ) 
            . ./create_tbl.sh
        ;;
        2 )
            . ./delete_tbl.sh
        ;;
        3 )
            . ./use_tbl.sh
        ;;
        
        4 )
            . ./list_tbl.sh
        ;;

        5 )
            clear
            echo
            echo "Exiting DB $db_name"
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




