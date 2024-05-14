#!/bin/bash  
#cd db 
PS3="CHOOSE YOUR OPTION OF MENU : "
echo "Data Base Management System"
if [ ! -d db ]	
then 
mkdir db
fi 
exflag=1
while ((exflag==1))
do
exflag=0
select choice in "create Data Base" "drop Data Base" "list Data Bases" "connect to Data Base" "exit from programe"
do
        case $REPLY in
        1)
             
             
             
             	flag=1
 
while ((flag==1))
do
	flag=0
	read -p " enter name of db you need creat "  answer
   #  // is the delimiter used for substitution.
   # `` (a space) is the pattern to match.
   # _ is the string to replace the matched pattern. 
if [[ $answer =~ " " ]] 
then
	answer=${answer// /_}	
else 
       answer=$answer	
fi
	# validate for that table name must not start by any number or special char except _ 	
if [[ ! $answer =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]
then	
     echo "Table must not begining with number or special character except _"
     flag=1
     # validate for that table name must be unique
elif [ -d db/$answer ]
then
        flag=1
        echo "This Database Exist enter another name"
fi
done
        mkdir db/$answer
        echo "your database is created succesfully"
       #  cd $answer
       # fi
        exflag=1
        break
         ;;
2)
	 read -p " enter db you need drop"  answer
        if [  -d db/$answer ]
        then
         rm -r db/$answer 
       	 echo "Drop successeful"
        else
        echo " this file does not exist yet " 
        fi
        exflag=1
        break
        ;;

3)
	   echo "************Data Bases Name************* "
	   echo	"****************************************"
				ls  db 
	   echo	"****************************************" 
	
     exflag=1
     break
     ;;
	

4)
     flag=1
     while ((flag==1))
     do
        
        read -p " which db you need connect : "  answer
        if [ -d db/$answer ]
        then
        #cd db/$answer
        flag=0
        echo "you are connected succesfully to " $answer
        else
        echo " this db not exist " 
        fi
       done
         path=./db/$answer
        #echo "$path"
       
        ./tableoption.sh $path
	exflag=1
	break
	;; 

5) 
  
 exflag=0
 break
 ;; 

esac
done
done
echo "GoodBye" 

