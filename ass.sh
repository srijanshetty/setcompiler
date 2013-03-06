#!/bin/bash

#Creating a temporary file to store the input
cat $1 > temp.txt
echo "The given expression is"
cat temp.txt
echo "Now parsing the given input for answers:"

#Compiling the code
flex scan.l
bison -d parse.y
gcc lex.yy.c parse.tab.c -o solution.o 2>/dev/null

#Executing
./solution.o < temp.txt

#Cleaning Up
