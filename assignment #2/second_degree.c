//Kaitlin Frani
//CPSC240-5 Quadratic Formula Calculator Assignment #2
//second_degree.c
///****************************************************************************************************************************
//Program name: Quadratic Formula Calculator
//Prints welcome message and calls on quadratic.asm to output none or one of the roots.
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
//  Program name: Quadratic Formula Calculator
//  Programming languages: Two modules in C++, one module in C, and one module in X86
//  Date program began: 2021-Feb-24
//  Date of last update: 2021-Feb-27
//  Date of reorganization of comments: 2021-Feb-27
//  Files in this program: quadratic.asm
//  Status: Finished. No errors when ran.

//This file
//  File name: second_degree.c
//  Language: C
//  Compile: gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11
//  Link: g++ -m64 -no-pie -o quadratic_calculator.out quadratic.o second_degree.o isfloat.o quad_library.o -std=c++17

//Purpose
// Prints welcome message and calls on quadratic.asm to output none or one of the roots found.
//****************************************************************************************************************************

//===== Begin second_degree.c ====================================================================================================
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>

extern double quadratic();

int main()
{
  float output = 0.0;

  printf("\nWelcome to Root Calculator\n");
  printf("Programmed by Kaitlin Frani, Professional Programmer.\n\n");

  double quadratic();
  output = quadratic();

  printf("The main driver received %.8lf and has decided to keep it.\n",output);
  printf("Now 0 will be returned to the operating system. Have a nice day. Bye.\n");

 return 0;
}
//===== End of second_degree.c ===================================================================================================
