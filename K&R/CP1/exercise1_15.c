#include <stdio.h>

#define UPPER 300
#define LOWER 0
#define STEP 20

float fahr_to_celsius(float fahr);

int main()
{
  float fahr;

  printf("Fahrenheit\tCelsius\n");
  for (fahr = LOWER; fahr <= UPPER; fahr += STEP) {
    printf("%3.0f\t\t%6.1f\n", fahr, fahr_to_celsius(fahr));
  }

  return 0;
}

float fahr_to_celsius(float fahr)
{
  float celsius = (5.0 / 9.0) * (fahr - 32.0);
  return celsius;
}
