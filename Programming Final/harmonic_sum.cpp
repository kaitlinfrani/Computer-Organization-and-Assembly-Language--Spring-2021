//Kaitlin Frani
//kaitlinfrani@csu.fullerton.edu
//Section 5
//harmonic_sum.cpp

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
