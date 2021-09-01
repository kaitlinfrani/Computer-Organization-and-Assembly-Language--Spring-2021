//Kaitlin Frani
//CPSC240-5 Test 1

#include <stdio.h>

extern "C" double electric_resistance();

int main(int argc, char* argv[])
{
  float output = 0.0;

  printf("Welcome to the Electric Resistance Calculator programmed by Kaitlin Frani\n");

  output = electric_resistance();

  printf("The Electricity module received this number %lf and has decided to keep it.\n",output);
  printf("Have a very nice evening. Electricity will now return 0 to the operating system. Bye.\n");

 return 0;
}
