
#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

clear

echo "Creating a Database"
while true
do

    
    echo "Enter the name of the database: "
    read db_name

    case $db_name in

    *\ *)
        echo "Invalid-> There must be not white spaces"
        ;;

    +([a-zA-Z0-9_]) ) 

        echo 

        if dirExist $db_name;
        then
            clear
            echo
            echo "DB $db_name is already exist !" 
            echo
        else
            clear
            echo
            echo "DB $db_name is created successfully !" 
            echo
            mkdir "./Databases/$db_name"
            if read 
            then
                return
            fi
            
            
        fi
        
        ;;

    *)
    echo "Invalid Input -> Must be alphanumeric" 
    
    ;;



    



    esac

done


