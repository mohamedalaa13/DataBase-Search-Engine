#!/bin/bash

shopt -s extglob
export LC_COLLATE=C

clear
echo
echo "Updating data into Table $tbl_name & Database $db_name "
echo



typeset -i num_cols
num_cols=`sed -n '1p' ./Databases/$db_name/$tbl_name`
pk_row=`sed -n '2p' ./Databases/$db_name/$tbl_name`
cols_types=`sed -n '3p' ./Databases/$db_name/$tbl_name`
cols_names=`sed -n '4p' ./Databases/$db_name/$tbl_name`
names=()
types=()
pk_arr=()



rows=`sed -n '5,$p' ./Databases/$db_name/$tbl_name`
arr_rows=($rows)




for k in $(echo $pk_row | sed "s/:/ /g")
do
    pk_arr+=("$k")
    
done


pk=${pk_arr[1]}
typeset -i pk_col
pk_col=${pk_arr[2]}
pk_data=(`sed -n '5,$p' ./Databases/$db_name/$tbl_name  | cut -d: -f $pk_col  `)
pk_col=$pk_col-1


for i in $(echo $cols_names | sed "s/:/ /g")
do
    names+=("$i")   
done

echo 

for j in $(echo $cols_types | sed "s/:/ /g")
do
    types+=("$j")   
done

echo 




for (( i= 0; i < $num_cols; i++ ))
do
    if [[ $i -eq $pk_col ]]
    then
         echo -ne " ${names[$i]}(PK)(${types[$i]}) |"
    else

         echo -ne " ${names[$i]}(${types[$i]}) |"
    fi
done

echo 
echo


if isEmpty $rows 
then 
    echo "Table is Empty -> No thinh to be Updated"
    echo
    echo "Press Enter to return"
    read
    clear
    return
fi



while true
do
    echo  "Enter The Primary Key Of The record To Be Updated : "
    read pk_val

    if isEmpty $pk_val
    then
        echo
        echo "Value Cannot Be Null!"
        continue
    fi

    index=0
    for i in "${pk_data[@]}"
    do
        if [[ $i = $pk_val ]]
        then
            old_record="${arr_rows[index]}"
            break 2
        fi
    let index=$index+1
    done

    echo
    echo "Record Not Found !!"

    
done

echo
echo "The Old Record to Be Updated"
echo



for (( i= 0; i < $num_cols; i++ ))
do
    if [[ $i -eq $pk_col ]]
    then
         echo -ne " ${names[$i]}(PK)(${types[$i]}) |"
    else

         echo -ne " ${names[$i]}(${types[$i]}) |"
    fi
done

echo
echo


old_record_arr=()
for i in $(echo $old_record | sed "s/:/ /g")
do    
    old_record_arr+=("$i")
    echo -ne "    $i    |"
done

echo 
echo

while true
do

    while true
    do
        echo
        echo  "Enter Column Name You Want To Update In The Record : "
        read updated_col_name

        if isEmpty $updated_col_name
        then
            echo
            echo "Value Cannot Be Null!"
            continue
        fi
        indx=0
        for i in "${names[@]}"
        do
            if [[ $i = $updated_col_name ]]
            then
                updated_col_type=${types[indx]}
                break 2
            fi
            let indx=$indx+1
        done

        echo
        echo "Wrong Column Name - Refer to Table Schema !"
        echo


    done


    while true
    do
        echo
        echo -ne "Enter New value Of $updated_col_name Of Type $updated_col_type : "
        echo
        read new_val


        if [[ $updated_col_name = $pk ]]
        then

            for l in "${pk_data[@]}"; do
                if [[ $l = $new_val ]]
                then
                    echo "Invalid-Primary key must be unique !!"
                    continue 2

                fi
            done
            
        fi


        if isEmpty $updated_col_name
        then
            echo
            echo "Value Cannot Be Null!"
            continue
        fi

        if ! check_type "${types[$indx]}" "$new_val" 
        then
			echo
			echo "Type Didnot Match, Please Refer to The Schema!"
			continue
        
		fi
        break

    done

    
    echo
    old_record_arr[$indx]="$new_val"
    new_line=$( IFS=$':'; echo "${old_record_arr[*]}" )
    new_line=$new_line:
    

    sed -i "s/$old_record/$new_line/" "./Databases/$db_name/$tbl_name"

    old_record=$new_line

    clear
    echo 
	echo -e "Record Updated Successfully"

    echo
	

    while true
    do

        echo "Select Your Choice"
        echo
        echo "1) Update another column for this record"
        echo "2) Exit Update"

        read choice

        case $choice in
            1 ) 
                clear
                continue 2
            ;;
            2 )
                clear
                break 2
            ;;
            *)
                clear
                echo
                echo "$choice is not valid option."
                echo

            ;;
        esac

    done



done










