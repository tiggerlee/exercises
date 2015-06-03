#include <stdio.h>

int is_little_endian() {
  int val = 1;
  char *p = (char *) &val;
  return *p == val;
}

int main() {
  if (is_little_endian)
    printf("Little endian\n");
  else
    printf("Big endian\n");
  return 0;
}
  
