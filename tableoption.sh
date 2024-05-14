#!/bin/bash
exflag=1
while ((exflag==1))
do
echo "Table features"
select choice in "create table" "drop table" "insert table" "select from table "  "delete from table" " update table" "Show Tables" "Back To main menue" 
do 
case $REPLY in 
	1)  ./createTable.sh $1
	exflag=1
	break ;;
	2)  ./dropTable.sh $1
	exflag=1
	break ;;
	3)  ./insert.sh $1
	exflag=1 
	break;;
	4) ./select.sh $1
	exflag=1
	break ;;
	5) ./delete.sh $1 
	exflag=1
	break ;;
	6) ./update.sh $1
	exflag=1 
	break;;
	7) 
	   echo "***************All Tables*************** "
	   echo	"****************************************"
			ls $1
	   echo	"****************************************" 
	
	exflag=1
	break;;
	8) exflag=0
	break ;;
	
	
	
esac
done
 
 
done
./manipulation.sh	
