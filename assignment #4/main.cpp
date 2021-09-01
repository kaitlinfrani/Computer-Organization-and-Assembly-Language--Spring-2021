//main
/********************************************************************************************
Program name:          Interview for Specific Applicants                                    *
Programming Language:  C++                                                                  *
Program Description:   This program will output certain offers, depending on the salary.    *
                                                                                            *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Kaitlin Frani                                                               *
; Email:        kaitlinfrani@csu.fullerton.edu                                              *
; Course:       CPSC 240-05 Assembly Language                                               *
;                                                                                           *
;********************************************************************************************
; Copyright (C) 2021 Kaitlin Frani                                                          *
; This program is free software: you can redistribute it and/or modify it under the terms   *
; of the GNU General Public License version 3 as published by the Free Software Foundation. *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
;********************************************************************************************
;  Program information                                                                      *
;  Program name: Interview for Specific Applicants                                          *
;  Programming languages: One module in C++, One module in X86                              *
;  Files in this program: interview.asm, main.cpp                                           *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      main.cpp                                                                    *
;    Purpose:   To input a char and use it for an input data file                           *
;    Link: g++ -m64 -no-pie -o job_interview.out -std=c++17 interview.o main.o -std=c++17   *
;********************************************************************************************
*/

#include <iostream>
#include <iomanip>
#include <string>
#include <stdio.h>
#include <stdint.h>
#include<stdlib.h>

extern "C" double interview(char name[], double salary);

int main(int argc, char* argv[]) {
  char name[100];
  float salary;
  float amount;

  std::cout << "Welcome to Software Analysis by Paramount Programmers, Inc.\n";
  std::cout << "Please enter your first and last names and press enter: ";
  std::cin.getline(name, sizeof(name));

  std::cout << "Thank you " << name << ".Our records show that you applied for employment"
            << " here with our agency a week ago.\n";
  std::cout << "Please enter your expected annual salary when employed at Paramount: ";
  std::cin >> amount;
  std::cout << "Your interview with Ms Linda Fenster, Personnel Manager, will begin shortly.\n";
  salary = interview(name, amount);
  //take from ranges

  //SOCIAL MAJOR
  if (salary < 50000) {
    std::cout << "Hello " << name << " I am the receptionist.\n";
    printf("We have an opening for you in the company cafeteria for $%.2lf annually.\n", salary);
    printf("Take your time to let us know your decision.\nBye\n");
  }

  //CS MAJOR
  else if (salary < 100000) {
    std::cout << "Hello " << name << " I am the receptionist.\n";
    printf("This envelope contains your job offer with starting salary $%.2lf.", salary);
    printf(" Please check back on Monday morning at 8am.\nBye\n");
  }

  //CHRIS SAWYER
  else if (salary >= 200000) {
    std::cout << "\nHello Mr. Sawyer I am the receptionist.\n"
              << "This envelope has your job offer starting at 1 million annual."
              << " Please start any time you like. In the middle time our CTO wishes to have dinner with you.\n"
              << "Have a very nice evening Mr. Sawyer.\n";
  }

  return 0;
}
