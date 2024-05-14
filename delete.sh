#!/bin/bash 
#read -p " enter your table you need to delete from it : " tableName

flag=1
while ((flag==1))
do
        flag=0
        read -p "Enter table name you wanted to delete from it : " tableName
        echo $1/$tableName
if [ ! -f $1/$tableName ]
then
        flag=1
        echo "Table is not exist please enter exist table"
fi
done











select choice in "Truncate table" "base on condition " 
do 
	case $REPLY in 
		1) sed -i '4,$d' $1/$tableName
			echo "Your data deleted successfully"
			echo "you are now in Table option menue"
			break ;;


		2)     
			let flag=1
			let ansnmber
			
		       	while ((flag==1))
			do
				 flag=1
				
		        		read -p "enter the name  of column : " ans
                 # set -x
			flag=($(awk -v awkflag="$flag" -v column="$ans"  'NR==1{
			       	for (i=1 ; i<=NF; i++){
				   if ($i == column)
			           {
			  
			               
					awkflag=0;		   
				   }
			      	}
		} END {print awkflag }' "$1/$tableName"))
		indexOfField=($(awk  -v column="$ans" -v indexOfField="$indexOfField" 'NR==1{
			       	for (i=1 ; i<=NF; i++){
				   if ($i == column)
			           {
			  
			                indexOfField=i
						   
				   }
			      	}
		} END {print indexOfField }' "$1/$tableName"))
		#echo "$ansnumber"
		#set +x
		                 if [ $flag -eq 1 ]
				then
				echo "Column does not exist. Please enter an existing column." 
				fi

			done
	#read -p "enter the name  of column : " ans
	read -p "enter value you need to delete : " delete_val
	#set -x
	 line_numbers=$(awk '{ if ($'$indexOfField'=="'"$delete_val"'") if(NR>=4) print NR }' "$1/$tableName" | tac)

            if [[ -n "$line_numbers" ]]
             then
                while read -r line_number
                  do
                    echo "Line number: $line_number"
                    sed -i "${line_number}d" "$1/$tableName"
                done <<< "$line_numbers"
                echo "Delete successful"
            else
                echo "This value does not exist."
            fi
            echo "you are now in Table option menue"
	break
	;;
	esac
done 	
