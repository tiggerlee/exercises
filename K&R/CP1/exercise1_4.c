#include <stdio.h>

/* print Celsius-Fahrenheit table
   for celsius = -20, 10, ..., 160 */
main()
{
  float fahr, celsius;
  int lower, upper, step;
  
  lower = -20;
  upper = 160;
  step = 7;
  
  celsius = lower;
  printf("Celsius\t\tFahrenheit\n");
  printf("-------------------------\n");
  while (celsius <= upper) {
    fahr = celsius / (5.0 / 9.0) + 32.0;
    printf("%6.1f\t\t%4.1f\n", celsius, fahr);
    celsius = celsius + step;
  }
}
