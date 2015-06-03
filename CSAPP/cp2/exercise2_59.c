#include <stdio.h>

int main() {
  int x = 0x89ABCDEF;
  int y = 0x76543210;
  int result = (x & 0xFF) | (y ^ (y & 0xFF));
  printf("The result is: %x\n", result);
  return 0;
}
