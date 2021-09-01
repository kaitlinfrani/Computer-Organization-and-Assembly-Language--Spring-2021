#run.sh file saves programs as files and executes them with bash

#Author: Kaitlin Frani
#Program: Perimeter and Average Length Side of a Rectangle

#deletes some of the un needed files
rm *.o
rm *.out

echo "Assemble the perimeter.asm file."
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

echo "Compile the rectangle.cpp file."
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17

echo "Link the object files using the gcc linker standard 2017."
gcc -m64 -no-pie -o rectanglearea.out rectangle.o perimeter.o -std=c++17

echo "The 'Perimeter and Average Side Length of a Rectangle' program will now run:"
./rectanglearea.out
