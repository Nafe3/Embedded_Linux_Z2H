#!/bin/bash
clear

if ! [ -f phonebookDB.txt ]
then
	touch phonebookDB.txt
fi

case $1 in
#insert new name and number
"-i")
	read -p "Enter new contact's name: " name
	read -p "Enter new contact's number: " number
	echo -n $name >> phonebookDB.txt
	echo -e "\t\t"$number >> phonebookDB.txt
;;
"-v")
	cat phonebookDB.txt
;;
#search by name
"-s")
	read -p "Enter contact's name to search for:" sname
	#-i option makes the grep ignore case sensitivity
	#-w is for exact match	
	ret=$(grep -i -w -ci "$sname" phonebookDB.txt)
	if [ $ret == 0 ]
	then 
		echo -e "No Record !"
	else
		grep -i -w "$sname" phonebookDB.txt
	fi	
;;
#delete all records
"-e")
#	>phonebookDB.txt
	rm phonebookDB.txt
	touch phonebookDB.txt
;;
#delete line
"-d")
	read -p "Enter a line to delete: " DLine
	sed -i -e  "/\<${DLine}\>/d" phonebookDB.txt
;;
*)
#guide if user doesn't enter an option
	echo -e "phonebook help:"
	echo -e "[OPTIONS]"
	echo -e "-i\tto insert new name and number"
	echo -e "-v\tview all saved contacts details"
	echo -e "-s\tsearch by contact name"
	echo -e "-e\tDelete all records"
	echo -e "-d\tDelete only one contact name"
;;
esac
	
