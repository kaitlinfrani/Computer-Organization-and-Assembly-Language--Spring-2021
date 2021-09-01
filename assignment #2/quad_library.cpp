//Kaitlin Frani
//CPSC240-5 Quadratic Formula Calculator Assignment #2
//quad_library.cpp
//****************************************************************************************************************************
//Program name: Quadratic Formula Calculator
//We are defining functions so that they will output one root, two roots, or no roots.
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
//  File name: quad_library.cpp
//  Language: C++
//  Compile: g++ -c -Wall -m64 -no-pie -o quad_library.o quad_library.cpp -std=c++17
//  Link: g++ -m64 -no-pie -o quadratic_calculator.out quadratic.o second_degree.o isfloat.o quad_library.o -std=c++17

//Purpose
// Functions that will output no roots, one root, or two roots
//****************************************************************************************************************************

//===== Begin quad_library.cpp====================================================================================================
//header file for printf
#include <stdio.h>

//will allow quadratic.asm to output the no root message
extern "C" void show_no_root()
{
  // if discriminant < 0, then no roots, impossible
  printf("There are no roots.\n");
}

//will allow quadratic.asm to output one root
extern "C" void show_one_root(double root){
  // if discriminant = 0, then show one root
  printf("There is only one root. The root is %.8lf\n",root);
}

//will allow quadratic.asm to output two roots
extern "C" void show_two_root(double root1, double root2){
  // if discriminant > 0 then show two roots
  printf("There are two roots. The roots are %.8lf and %.8lf\n",root1,root2);
}
//===== End of quad_library.cpp ==================================================================================================
