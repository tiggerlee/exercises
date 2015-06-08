#include <stdio.h>

int bad_int_size_is_32() {
  /* Set most significant bit (msb) of 32-bit machine */
  int set_msb = 1 << 31;
  /* Shift past msb of 32-bit word */
  int beyond_msb = 1 << 32;
  /* set_msb is nonzero when word size >= 32
   * beyond_msb is zero when word size <= 32 */
  return set_msb && !beyond_msb;
}

/*
 * 问题A
 * 因为左移的位数大于或等于位向量的长度，在C标准里面，这个时候的结果是未定义的，会产生不可预期的结果
 */

/*
 * 问题B
 * 因为上面的代码主要问题就是左移的位数产生的问题，我们可以将左移拆分成两步，第一步左移31位，然后将左移31位的结果再左移1位，达到了左移32位的结果，并且不会产生不可预期的结果
 */

int int_size_is_32() {
  int set_msb = 1 << 31;
  int beyond_msb = 1 << 31;
  beyond_msb = beyond_msb << 1;
  return set_msb && !beyond_msb;
}

/*
 * 问题C
 * 在16位的机器上，我们要保证的就是左移的长度小于16，要左移32位，我们拆分成15 + 15 + 2
 */
int int_size_is_32_for_16bit() {
  int set_msb = 1 << 15;
  set_msb = set_msb << 15;
  set_msb = set_msb << 1;
  int beyond_msb = 1 << 15;
  beyond_msb = beyond_msb << 15;
  beyond_msb = beyond_msb << 2;
  return set_msb && !beyond_msb;
}

int main() {
  printf("Int size is 32 in 32-bit machine: %d\n", int_size_is_32());
  printf("Int size is 32 in 16-bit machine: %d\n", int_size_is_32_for_16bit());
  return 0;
}
