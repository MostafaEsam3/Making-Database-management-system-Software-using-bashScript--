#!/bin/bash  
flag=1

while ((flag==1))
do
	flag=0
	  read -p "Enter table name " 
	  tableName=$REPLY
          if [ ! -f $1/$tableName ]
           then
           flag=1
           echo "This table Not Exist enter another name"
         fi
          
done
rm $1/$tableName
echo "you are droped $tableName"
