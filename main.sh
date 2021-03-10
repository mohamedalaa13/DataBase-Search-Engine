#!/bin/bash

clear

. ./functions.sh

#select choice in CreateDB OpenDB DeleteDB ListDB EXIT
while true
do
    clear
    echo "DataBase Search Engine"
    echo
    echo "1) Create DB"
    echo "2) Open DB "
    echo "3) Delete DB "
    echo "4) List DBs "
    echo "5) Exit "
    echo
    echo -ne "Enter your select : "

    read choice

    case $choice in
        1 ) 
            . ./create_db.sh
        ;;
        2 )
            . ./open_db.sh
        ;;
        3 )
            . ./delete_db.sh
        ;;
        
        4 )
            . ./list_db.sh
        ;;
        
        5 )
            exit 0
        ;;
        
        *)
            clear
            echo
            echo "$choice is not valid option."
            echo
        ;;
    esac
done

