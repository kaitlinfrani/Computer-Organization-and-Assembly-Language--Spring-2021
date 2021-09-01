//Kaitlin Frani
//kaitlinfrani@csu.fullerton.edu
//Section 5
//harmonic_sum.cpp

#include <stdio.h>

extern "C" double harmonic_sum();

int main()
{
  float output = 0.0;

  printf("This is 240-5 programming final by Kaitlin Frani.\n\n");

  output = harmonic_sum();

  printf("\nThe main function received this number and will keep it: %.9lf\n",output);
  return 0;
}
