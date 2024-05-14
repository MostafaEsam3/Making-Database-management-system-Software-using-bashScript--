#!/bin/bash

flag=1
while ((flag==1))
do
        flag=0
        read -p "Enter table name : "
   #  // is the delimiter used for substitution.
   # `` (a space) is the pattern to match.
   # _ is the string to replace the matched pattern. 
if [[ $REPLY =~ " " ]]
then
        tableName=${REPLY// /_}
else 
        tableName=$REPLY
fi
        # validate for that table name must not start by any number or special char except _    
if [[ ! $tableName =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]
then
     echo "Table must begining with any letters  or _ "
     flag=1
     # validate for that table name must be unique
elif [ ! -f $1/$tableName ]
then
        flag=1
        echo "Table is not exist please enter exist table"
fi
done
newRow=""

	#IFS for internal field seprator and here i use \t as delimiter and use this to use header of table from table file here without using export 
	IFS=$'\t' read -ra arr < <(head -n 1 "$1/$tableName")
        # to read second line from table file that has data type of columns to check input == same data type in structure of table or not and <(command) to pass it's output to read command and -r to make '\' not escaping char so it can use with \t sec_arr name i defined to store second line of table in it 
        IFS=$'\t' read -ra sec_arr< <(awk '{if(NR==2)print $0}' "$1/$tableName")

	IFS=$'\t' read -ra constrains < <(awk '{if(NR==3)print $0}' "$1/$tableName")
         primary_key_index=0
for ((i = 0; i < ${#constrains[@]}; i++))
do
    if [[ "${constrains[i]}" == "primary_key" ]]
    then
        primary_key_index=$i
        break
    fi
done                       
      old_primar_key_values=($(awk -v col="$primary_key_index" 'NR>=4 {print $col}' "$1/$tableName" ))                         	
	length=${#arr[@]}
	for ((i=0; i<$length;i++ )) 
	do
	        
	
            flag=1
		while ((flag==1))
		do
		        flag=0
			read -p "Enter data of ${arr[i]} : "
			#echo "${sec_arr[i]}"
			if [[ ${sec_arr[i]} == "string" ]]
			then
				if [[  $REPLY =~ ^[0-9]*$ ]]
				then
					flag=1
					echo "you must enter string not number only"
				
				fi
			elif [[ ${sec_arr[i]} == "int" ]]
			then
				if [[ ! $REPLY =~ ^[0-9]*$ ]]
				then
					flag=1
					echo "you must enter only number"
				fi
			fi
			          #echo $i
				if [[ $i -eq  $primary_key_index ]]
				then
				found_duplicate=0
					 
		 
		       for old_value in "${old_primar_key_values[@]}"
		       do
		       	if [[ "${REPLY,,}" == "${old_value,,}" ]]
		       	then
		       		found_duplicate=1
		       		echo "Duplicate value. Please enter a different value."
		       		flag=1
		       		break
		       	fi
		       	done
		       	
		
	
		fi
			
		done
		
		newRow+="$REPLY\t"
		  
	done
	#echo $newRow
	echo -e "$newRow" >> $1/$tableName
#else
	echo "Insert done Successfuly"
#fi

