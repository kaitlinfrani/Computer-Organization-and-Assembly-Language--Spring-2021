//Kaitlin Frani
//CPSC240-5 Sum of Floats in an Array Assignment #3
//display.cpp
//****************************************************************************************************************************
//Program name: Sum of Floats in an Array
//We are using a for loop to output the values we inputted into the array.
//Copyright (C) 2021 Kaitlin Frani.
//This program is free software: you can redistribute it and/or modify it under the terms
//of the GNU General Public License version 3 as published by the Free Software Foundation.
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY
//without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
//See the GNU General Public License for more details.
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
//****************************************************************************************************************************

//****************************************************************************************************************************
//Author information
//  Author name: Kaitlin Frani
//  Author email: kaitlinfrani@csu.fullerton.edu

//Program information
//  Program name: Sum of Floats in an Array
//  Programming languages: One module in C++, one module in C, and three modules in X86
//  Date program began: 2021-Mar-18
//  Date of last update: 2021-Mar-21
//  Date of reorganization of comments: 2021-Mar-21
//  Files in this program: control.asm
//  Status: Finished. No errors when ran.

//This file
//  File name: display.cpp
//  Language: C++
//  Compile: gcc -c -Wall -m64 -no-pie -o display.o display.cpp -std=c++17
//  Link: g++ -m64 -no-pie -o array_summation.out control.o fill.o sum.o display.o main.o -std=c++17

//Purpose
//Will output the floating values inputted into the array.
//****************************************************************************************************************************

//===== Begin display.cpp====================================================================================================
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
extern double control();

extern "C" void display(double array[], long index) {
  for (int i = 0; i < index; ++i)
  {
    printf("%.8lf", array[i]);
    printf("\n");
  }
}
//===== End of display.cpp ==================================================================================================
