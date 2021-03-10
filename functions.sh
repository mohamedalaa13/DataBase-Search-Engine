#!/bni/bash


function dirExist 
{

    if [[ -d "./Databases/$1" ]];
    then
        return 0
    else
        return 1
    fi

}


function filExist 
{

    if [[ -f "./Databases/$1/$2" ]];
    then
        return 0
    else
        return 1
    fi

}



function isEmpty
{

    if [[ -z $1 ]];
    then
        return 0
    else
        return 1
    fi

}


function isDirEmpty
{
    if [ "$(ls -A "$1")" ]; 
    then
        return 1
    else
        return 0
    fi
}



function list_dbs
{
    
    echo
    echo "Listing Databases"
    echo "********************************"
	echo 

    ls -1 "./Databases"

    echo 
	echo "********************************"



}


function list_tables
{
    
    echo
    echo "Listing Tables of Database $db_name"
    echo "********************************"
	echo 

    ls -1 "./Databases/$db_name" 

    echo 
	echo "********************************"



}


function check_type
{

    case "$1" in
		int )
			if [[ "$2" =~ ^[0-9]+$ ]]; then
				return 0
			else return 1
			fi
			;;
		string )
			if [[ "$2" =~ ^[a-zA-Z0-9_" "]+$ ]]; then
				return 0
			else return 1
			fi
			;;
		* )
			return 1
			;;
	esac
}

}