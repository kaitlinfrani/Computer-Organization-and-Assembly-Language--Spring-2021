#run.sh file saves programs as files and executes them with bash

#Kaitlin Frani
#CPSC240-05 Test 1
#Program: Electric Resistance Calculator

#deletes some of the un needed files
rm *.o
rm *.out

echo "Assemble the resistance.asm file."
nasm -f elf64 -l resistance.lis -o resistance.o resistance.asm

echo "Compile the electricity.cpp file."
gcc -c -Wall -m64 -no-pie -o electricity.o electricity.cpp -std=c++17

echo "Link the object files using the gcc linker standard 2017."
gcc -m64 -no-pie -o calculator.out electricity.o resistance.o -std=c++17

echo "The 'Electric Resistance Calculator' program will now run:"
./calculator.out
