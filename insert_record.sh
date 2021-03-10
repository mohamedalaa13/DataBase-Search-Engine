#!/bin/bash

clear
echo
echo "Inserting data into Table $tbl_name & Database $db_name "
echo


typeset -i num_cols
num_cols=`sed -n '1p' ./Databases/$db_name/$tbl_name`
pk_row=`sed -n '2p' ./Databases/$db_name/$tbl_name`
cols_types=`sed -n '3p' ./Databases/$db_name/$tbl_name`
cols_names=`sed -n '4p' ./Databases/$db_name/$tbl_name`
names=()
types=()
pk_arr=()
record=()





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


for j in $(echo $cols_types | sed "s/:/ /g")
do
    types+=("$j")
        
done

echo "" 



for (( i= 0; i < $num_cols; i++ ))
do
    if [[ $i -eq $pk_col ]]
    then
         echo -ne " ${names[$i]}(PK)(${types[$i]}) |"
    else

         echo -ne " ${names[$i]}(${types[$i]}) |"

    fi
done


echo ""



for (( i= 0; i < $num_cols; i++ ))
do
    
    echo
    
    while true
    do  
        
        


        echo "Enter the value of ${names[i]}"
        read value

        if [[ $i = $pk_col ]]
        then

            for l in "${pk_data[@]}"; do
                if [[ $l = $value ]]
                then
                    echo "Primary key must be unique !!"
                    continue 2

                fi
            done
            
        fi

        if isEmpty $value
        then
            echo "Value Cannot Be Null!"
            continue
        fi

        if ! check_type "${types[$i]}" "$value" 
        then
			echo 
			echo "Type Didnot Match, Please Refer to The Schema!"
			continue
		fi
        break

    done


    value="${value// /}"
    record+=("$value")


done


for (( i = 0; i < $num_cols; i++ )); do
	echo -n "${record[$i]}:" >> "./Databases/$db_name/$tbl_name"
done

echo "" >> "./Databases/$db_name/$tbl_name"

clear
echo
echo -e "Data Inserted to $tbl_name Successfully"
echo
echo "Press Enter to return"
read
clear
return

