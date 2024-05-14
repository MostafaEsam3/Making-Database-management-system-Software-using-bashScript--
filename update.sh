#!/bin/bash

flag=1
while [ $flag -eq 1 ]
 do
    flag=0
    read -p "Enter table name you want to update data in: " tableName

    if [ ! -f "$1/$tableName" ]
     then
        flag=1
        echo "Table does not exist. Please enter an existing table."
    fi
done

select choice in "Update data based on condition"
 do
    case $REPLY in
        1)
            let flag=1
            let indexOfField

            while [ $flag -eq 1 ]
             do
                flag=1
                read -p "Enter the name of column to update: " ans

                flag=($(awk -v awkflag="$flag" -v column="$ans" '
                    NR==1 {
                        for (i=1; i<=NF; i++) {
                            if ($i == column) {
                                awkflag=0;
                            }
                        }
                    } END {print awkflag }' "$1/$tableName"))

                indexOfField=$(awk -v column="$ans" '
                    NR==1 {
                        for (i=1; i<=NF; i++) {
                            if ($i == column) {
                                indexOfField=i;
                            }
                        }
                    } END {print indexOfField }' "$1/$tableName")

                if [ $flag -eq 1 ]
                 then
                    echo "Column does not exist. Please enter an existing column."
                fi
            done

            read -p "Enter value in the specified column to update: " update_val
            read -p "Enter new value: " new_val

            line_numbers=$(awk '{ if ($'$indexOfField'=="'"$update_val"'") if(NR>=4) print NR }' "$1/$tableName")

            if [[ -n "$line_numbers" ]]
             then
                while read -r line_number
                 do
                    sed -i "${line_number}s/$update_val/$new_val/" "$1/$tableName"
                    echo "Updated data in line $line_number: $update_val -> $new_val"
                done <<< "$line_numbers"
                echo "Update successful"
            else
                echo "No matching data found based on the provided condition."
            fi
            echo "You are now in the Table option menu"
            break ;;
    esac
done

