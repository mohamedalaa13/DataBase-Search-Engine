#!/bin/bash

clear
echo
echo "Deleting Record from Table ( $tbl_name ) & Database ( $db_name )"
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
    echo "Table is Empty -> No thinh to be Deleted"
    echo
    echo "Press Enter to return"
    read
    clear
    return
fi


while true
do
    echo  "Enter The Primary Key Of The record To Be Deleted : "
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

clear
echo
echo "The Record to Be Deleted"
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

sed -i "/$old_record/d" "./Databases/$db_name/$tbl_name"


echo -e "Record Deleted Successfully"

echo
echo "Press Enter to return"
read
return
