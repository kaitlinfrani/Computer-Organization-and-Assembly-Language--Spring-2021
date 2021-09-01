#!/bin/bash
#run.sh file saves programs as files and executes them with bash

#Kaitlin Frani
#CPSC240-05 Assignment #2
#Program: Quadratic Formula Calculator

#deletes some of the un needed files
rm *.o
rm *.out

echo "Assemble the quadratic.asm file."
nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm

echo "Compile the isfloat.cpp and quad_library.cpp files."
g++ -c -Wall -m64 -no-pie -o isfloat.o isfloat.cpp -std=c++17

g++ -c -Wall -m64 -no-pie -o quad_library.o quad_library.cpp -std=c++17

echo "Compile the second_degree.c file."
gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11

echo "Link the object files using the gcc linker standard 2017."
g++ -m64 -no-pie -o quadratic_calculator.out quadratic.o second_degree.o isfloat.o quad_library.o -std=c++17

echo "The 'Quadratic Formula Calculator' program will now run:"
./quadratic_calculator.out

echo "The script file will now terminate."
