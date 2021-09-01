//=============================================================================================================================
//Program name: "Perimeter and Average Side Length of a Rectangle"
//We want to find out the perimeter and the length of the average side given width and height.
//Copyright (C) 2021 Kaitlin Frani.

//This file is part of the software program "Perimeter and Average Side Length of a Rectangle".
//Perimeter and Average Side Length of a Rectangle is free software: you can redistribute it
//and/or modify it under the terms of the GNU General Public License version 3 as published
//by the Free Software Foundation.
//Area of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
//=============================================================================================================================


//=============================================================================================================================
//
//Author information
//  Author name: Kaitlin Frani
//  Author email: kaitlinfrani@csu.fullerton.edu

//Program information
//  Program name: Area of Rectangle
//  Programming languages: One module in C++ and one module in X86
//  Date program began: 2021-Feb-4
//  Date of last update: 2021-Feb-13
//  Date of reorganization of comments: 2021-Feb-13
//  Files in this program: rectangle.cpp, perimeter.asm
//  Status: Finished. No errors when ran.

//This file
//  File name: rectangle.cpp
//  Language: C++
//  Compile: gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17
//  Link: gcc -m64 -no-pie -o rectanglearea.out rectangle.o perimeter.o -std=c++17
//
//Purpose
//  Show how to calculate the perimeter and average length of sides from the input and output them as floats
//
//=============================================================================================================================
//
//===== Beginning of messages we want to output through main ===========================================================================================================
// This file will grab the perimeter value from the assembly file.

#include <stdio.h>

extern "C" double area_rectangle();

int main(int argc, char* argv[])
{
  float output = 0.0;

  printf("Welcome to a friendly assembly program by Kaitlin Frani.\n");

  output = area_rectangle();

  printf("The main function received this number %3.2lf and has decided to keep it.\n",output);
  printf("A 0 will be returned to the operating system.\n");
  printf("Have a nice day\n");

 return 0;
}
//===== End of messages we want to output through main ===========================================================================================================
