#include <stdio.h>

/* x的所有位都为1的时候返回1，其他返回0 */
int exp_a(int x) {
  return !~x;
}

/* x的所有位为0的时候返回1，其他返回0 */
int exp_b(int x) {
  return !(x || 0);
}

/* x的最高有效字节中的位都等于1的时候返回1，其他返回0 */
int exp_c(int x) {
  int shift_right = x >> ((sizeof(int) - 1) << 3);
  return exp_a(shift_right);
}

/* x最低有效字节都等于0返回1，其他返回0 */
int exp_d(int x) {
  int shift_left = x << ((sizeof(int) - 1) << 3);
  return exp_b(shift_left);
}

int main() {
  int all_bit_1 = ~0;
  int all_bit_0 = ~all_bit_1;
  int high_byte_1 = 0xFF000000;
  int high_byte_not_1 = 0xF0000000;
  int low_byte_0 = 0xFFFFFF00;
  int low_byte_not_0 = 0xFFFFFF0F;
  printf("exp_a now should be 1 and the result is %d\n", exp_a(all_bit_1));
  printf("exp_a now should be 0 and the result is %d\n", exp_a(all_bit_0));
  printf("exp_b now should be 1 and the result is %d\n", exp_b(all_bit_0));
  printf("exp_b now should be 0 and the result is %d\n", exp_b(all_bit_1));
  printf("exp_c now should be 1 and the result is %d\n", exp_c(high_byte_1));
   printf("exp_c now should be 0 and the result is %d\n", exp_c(high_byte_not_1));
  printf("exp_d now should be 1 and the result is %d\n", exp_d(low_byte_0));
  printf("exp_d now should be 0 and the result is %d\n", exp_d(low_byte_not_0));
  return 0;
}
