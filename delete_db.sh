#!/bin/bash

clear

list_dbs

echo


if isDirEmpty "./Databases/"
then 
    echo "There is no Databases to be Deleted"
    echo
    echo "Press Enter to return"
    read
    clear
    return
fi




while true
do

echo "Enter the name of the database to delete: "
read db_name

if isEmpty $db_name
then
    clear
    echo
    echo "Database name can not be empty to delete !"
    echo
    if read 
    then
        return
    fi

fi

if dirExist $db_name;
then
    clear
    rm -r "./Databases/$db_name"
    echo
    echo "DB $db_name is deleted !" 
    echo
    if read 
    then
        return
    fi
else
    clear
    echo
    echo "DB $db_name is not exist to delete !" 
    echo
    if read 
    then
        return
    fi
        
     
fi

done