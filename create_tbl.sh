#!/bin/bash

shopt -s extglob
export LC_COLLATE=C

clear

echo "Creating a Table"
while true
do

    
    echo "Enter the name of the Table : "
    read tbl_name

    case $tbl_name in

    *\ *)
        echo "Invalid-> There must be not white spaces"
        ;;

    +([a-zA-Z0-9_]) ) 

        echo 

        if filExist $db_name $tbl_name;
        then
            clear
            echo
            echo "TABLE $tbl_name is already exist !" 
            echo
        else
            clear
            #echo
            #echo "TABLE $tbl_name is created successfully !" 
            echo
            touch "./Databases/$db_name/$tbl_name"

            break
            
            
        fi
        
        ;;

    *)
    echo "Invalid Input -> Must be alphanumeric" 
    
    ;;



    esac

done







while true
do

    
    echo "Enter the number of columns for table $tbl_name : "
    read num_cols

    case $num_cols in

    *\ *)
        echo "Invalid-> There must be not white spaces"
        ;;

        

    +([1-9]*([0-9])) ) 

        echo 

        echo "Your table $tbl_name is $num_cols columns !"

        echo "$num_cols" > "./Databases/$db_name/$tbl_name"

        break
        
        ;;

    *)
    echo "Invalid Input -> Must be numeric "  
    
    ;;



    esac

done


col_types=""
col_names=""


typeset -i counter
counter=1

let cols_number=$num_cols+1

while [[ $counter -lt $cols_number ]]
do


    flag=0
    while [[ $flag == 0 ]]
    do

        echo "Enter the name of column $counter: "

         read col_name

        case $col_name in

        *\ *)
            echo "Invalid-> There must be not white spaces"
            ;;

        +([a-zA-Z0-9_]) ) 

            echo 
            for i in $(echo $col_names | sed "s/:/ /g")
            do
                if [[ $i = $col_name ]]
                then
                    echo "Repeated column name, Enter name again!"
                    continue 2
                fi
            done
            col_names=$col_names:$col_name
            flag=1
            
            ;;

        *)
        echo "Invalid Input -> Must be alphanumeric" 
        
        ;;


        esac

    done






    echo "Select the type of column $counter: "
    select choice in "string" "int"
    do
        case $choice in
            "string" ) 
                col_types=$col_types:string
            break;;
            "int" )
                col_types=$col_types:int
            break;;
            
            *)
                echo "$REPLY is not one of the selection."
            ;;
    esac
    done



    counter=$counter+1


done


clear


while true
do
    
    echo "Enter the name of column to be the primary key from list of columns " 
   
    

    for i in $(echo $col_names | sed "s/:/ /g")
    do

        echo " -> $i"
        
        
    done

    read choice


    typeset -i pk_counter
    pk_counter=1
    for i in $(echo $col_names | sed "s/:/ /g")
    do
        if [[ $i = $choice ]]
        then
            clear
            echo "Your Primary Key is $choice"
            echo "pk:$choice:$pk_counter" >> "./Databases/$db_name/$tbl_name"

            break 2
        fi
        pk_counter=$pk_counter+1
    done

    echo "$choice is Not one of columns !"


done

echo "$col_types" >> "./Databases/$db_name/$tbl_name"
echo "$col_names" >> "./Databases/$db_name/$tbl_name"


echo
echo
echo "Table $tbl_name Created Successfully !"
echo
echo "Press Enter to return"
read
clear
return