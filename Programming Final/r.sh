#Kaitlin Frani
#kaitlinfrani@csu.fullerton.edu
#Section 5
#r.sh bash file

#deletes some of the un needed files
rm *.o
rm *.out
rm *.lis

echo "Assemble the harmonic.asm file."
nasm -f elf64 -l harmonic.lis -o harmonic.o harmonic.asm

echo "Compile the driver.cpp file."
gcc -c -Wall -m64 -no-pie -o driver.o driver.cpp -std=c++17

echo "Link the object files using the gcc linker standard 2017."
gcc -m64 -no-pie -o harmonicSum.out driver.o harmonic.o -std=c++17

echo "The 'Harmonic Sum Calculator' program will now run:\n"
./harmonicSum.out
