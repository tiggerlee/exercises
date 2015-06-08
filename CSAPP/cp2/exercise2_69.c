#include <stdio.h>

/*
 * Examples: x = 0x12345678, n = 4 --> 0x81234567, n = 20 --> 0x45678123
 *
 * 我们可以用 (x >> n) | (x << w - n) 来解决这个问题
 * 但是要注意的是n = 0的时候，(x << w - n) 相当于 x << w，避免这个问题，需要对于n = 0特殊处理
 */
unsigned rotate_right(unsigned x, int n) {
  int w = sizeof(int) << 3;
  unsigned shift_left_count = 0;
  /* n = 0 时shift_left_count = 0 其他情况下 shift_left_count = w - n */
  n == 0 || (shift_left_count = w - n);
  x = (x >> n) | (x << shift_left_count);
  return x;
}

int main() {
  unsigned x = 0x12345678;
  int s4 = 4; /* -> 0x81234567 */
  int s20 = 20; /* -> 0x45678123 */
  int s0 = 0;
  int s24 = 24;
  printf("N = %d and result is: %x\n", s4, rotate_right(x, s4));
  printf("N = %d and result is: %x\n", s20, rotate_right(x, s20));
  printf("N = %d and result is: %x\n", s0, rotate_right(x, s0));
  printf("N = %d and result is: %x\n", s24, rotate_right(x, s24));
  return 0;
}
