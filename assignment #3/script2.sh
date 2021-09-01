#!/bin/bash
#run.sh file saves programs as files and executes them with bash

#Kaitlin Frani
#CPSC240-05 Assignment #2
#Program: Quadratic Formula Calculator

#deletes some of the un needed files
rm *.o
rm *.out
rm *.lis

echo "Assemble the control.asm, fill.asm, and sum.asm files."
nasm -f elf64 -l control.lis -o control.o control.asm -g
nasm -f elf64 -l fill.lis -o fill.o fill.asm -g
nasm -f elf64 -l sum.lis -o sum.o sum.asm -g

echo "Compile the display.cpp file."
gcc -c -Wall -m64 -no-pie -o display.o display.cpp -std=c++17 -g -gdwarf

echo "Compile the main.c file."
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11 -g -gdwarf

echo "Link the object files using the gcc linker standard 2017."
g++ -m64 -no-pie -o array_summation.out control.o fill.o sum.o display.o main.o -std=c++17 -g

echo "The 'Quadratic Formula Calculator' program will now run:"
./array_summation.out
gdb ./array_summation.out

echo "The script file will now terminate."
