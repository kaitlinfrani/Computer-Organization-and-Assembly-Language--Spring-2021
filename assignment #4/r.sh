#bash
#run.sh file saves programs as files and executes them with bash

#Kaitlin Frani
#CPSC240-05 Assignment #4
#Program: Job Interview

#deletes some of the un needed files
rm *.o
rm *.out
rm *.lis

echo "Assemble the interview.asm file."
nasm -f elf64 -l interview.lis -o interview.o interview.asm

echo "Compile the main.cpp file."
g++ -c -Wall -m64 -no-pie -o main.o main.cpp -std=c++17

echo "Link the object files using the gcc linker standard 2017."
g++ -m64 -no-pie -o job_interview.out -std=c++17 interview.o main.o

echo "The 'Job Interview' program will now run:"
./job_interview.out

echo "The script file will now terminate."
