#!/bin/bash
typeset -a  arr[2]
typeset -a sec_arr[2] 
typeset -a constrains[2]
#read -p "Enter table name" tableName
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
     echo "Table must not begining with number or special character except _"
     flag=1
     # validate for that table name must be unique
elif [ -f $1/$tableName ]
then
        flag=1
        echo "This table Exist enter another name"
fi
done
touch $1/$tableName 
flag=1
while ((flag==1))
do
flag=0
read -p "num of column " num_of_col
if [[ ! $num_of_col =~ ^[0-9]*$ ]]
then 
flag=1
echo "you must enter numbers only "
fi
done 
newRow=""
dataTypeRow=""
constrainsRow=""
#arr[0]="id"
#newRow+="${arr[0]}\t"
#sec_arr[0]="int"
#dataTypeRow+="${sec_arr[0]}\t"
for((i=0 ;i<$num_of_col;i++))
do 
	#read -p " enter name of column : " answer 
	#arr[i]=$answer
	flag=1
	# validate for column name must be unique
	while((flag==1))
	do
		flag=0
		read -p "enter name of column : " answer
		arr[i]=$answer
	     for ((j=0;j<i;j++))
	     do
                     if [[ ${arr[i]} == ${arr[j]}  ]]
		     then
			     flag=1
			     echo "this column name was exist enter another name"	
		    	     break
		     fi
	     done
	done
	newRow+="${arr[i]}\t"
	select choice in "int" "string" 
	do 
		case $REPLY in 
		1) sec_arr[i]="int"
			dataTypeRow+="${sec_arr[i]}\t"		
			break;;
			
		2)sec_arr[i]="string" 
			dataTypeRow+="${sec_arr[i]}\t"
			break ;;
	esac
	done 
	echo "do you want make this field primary_key [1 for yes or 2 for no]"
	select choice in "yes" "no"
	do
		case $REPLY in
		1) 
		    pk_flag=1;
		    for ((j=0; j<i; j++))
		    do
		    if [[ ${constrains[j]} == "PK" ]] 	
		    then   
			echo "Error: Only one column can be designated as the primary key and other columns will be NotNULL "

	                constrains[i]="N_NULL"
			 constrainsRow+="${constrains[i]}\t"
			 pk_flag=0
			 break
		    fi   
		    done
		    if [ $pk_flag -eq 1 ]
		    then
		    	constrains[i]="PK"
		    	constrainsRow+="${constrains[i]}\t"
		    fi
		    break
		    ;;
        	2) 
		 constrains[i]="N_NULL"
		 constrainsRow+="${constrains[i]}\t"
		 break
		 ;;
	       *) echo "Invalid option. please choose 1 or 2"
		 ;;
		 
		esac    
	done
     # read -p "datatype of ${arr[i]}:  " dataType
   #   sec_arr[i]=$dataType

done 
 echo -e "$newRow" >> $1/$tableName
 echo -e "$dataTypeRow" >> $1/$tableName
 echo -e "$constrainsRow" >> $1/$tableName
 echo "$tableName Table created successfully "


