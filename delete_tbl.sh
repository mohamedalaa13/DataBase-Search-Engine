#!/bin/bash

clear

list_tables
echo

if isDirEmpty "./Databases/$db_name"
then 
    echo "There is no Tables to be Deleted"
    echo
    echo "Press Enter to return"
    read
    clear
    return
fi

while true
do

echo "Enter the name of the table to delete: "
read tbl_name

if isEmpty $tbl_name
then
    clear
    echo
    echo "Table name can not be empty to delete !"
    echo
    if read 
    then
        return
    fi
fi

if filExist $db_name $tbl_name;
then
    clear
    rm -r "./Databases/$db_name/$tbl_name"
    echo
    echo "Table $tbl_name is deleted !" 
    echo
    if read 
    then
        return
    fi
else
    clear
    echo
    echo "Table $tbl_name is not exist to delete !" 
    echo
    if read 
    then
        return
    fi
        
     
fi

done