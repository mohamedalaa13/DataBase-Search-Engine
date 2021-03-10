#!/bin/bash

shopt -s extglob
export LC_COLLATE=C

clear
echo
echo "Listing data from Table ( $tbl_name ) & Database ( $db_name )"
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


for k in "${arr_rows[@]}"
do
    for i in $(echo $k | sed "s/:/ /g")
    do    
        
        echo -ne "    $i    |"
    done
    echo
    echo
done

echo
echo "Press Enter to return"
read
clear
return
