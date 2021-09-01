//Kaitlin Frani
//CPSC240-5 Sum of Floats in an Array Assignment #3
//main.c
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
//  File name: main.c
//  Language: C
//  Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11
//  Link: g++ -m64 -no-pie -o array_summation.out control.o fill.o sum.o display.o main.o -std=c++17

//Purpose
//Will output the introduction messages and receive the sum from control and return it.
//****************************************************************************************************************************

//===== Begin main.c ====================================================================================================
#include <stdio.h>
#include <stdlib.h>

extern double control();

int main()
{
  double output = -999;

  printf("\nWelcome to High Speed Array Summation by Kaitlin Frani.\n");
  printf("Software Licensed by GNU GPL 3.0\n");
  printf("Version 1.0 released on January 28, 2021.\n");

  output = control();

  printf("The main driver has received this number %.8lf and will keep it.\n",output);
  printf("Thank you for using High Speed Array Software.\n");
  printf("For system support contact Kaitlin Frani at kaitlinfrani@csu.fullerton.edu\n");
  printf("A zero will be returned to the operating system.\n");

 return 0;
}
//===== End of main.c ===================================================================================================
