#include <stdio.h>

/* x的所有位都为1的时候返回1，其他返回0 
 * 如果x所有位都为1，那么~x为0，!~x即为1
 * 如果x有位不为1，那么~x不为0，那么!~x即为0
 */
int exp_a(int x) {
  return !~x;
}

/* x的所有位为0的时候返回1，其他返回0
 * 如果x所有为都为0，那么 x || 0 为0，!(x || 0) 为1
 * 如果x有位不为0，那么 x || 0 不为0，!(x || 0)为0
 */
int exp_b(int x) {
  return !(x || 0);
}

/* x的最高有效字节中的位都等于1的时候返回1，其他返回0
 * 如果x最高有效字节中的位都为1，那么将x执行算数右移w-8位，那么所有位都为1，然后用第一个方法判断
 */
int exp_c(int x) {
  int shift_right = x >> ((sizeof(int) - 1) << 3);
  return exp_a(shift_right);
}

/* x最低有效字节都等于0返回1，其他返回0
 * 如果x的最低有效位都为0，那么将x执行左移w-8位，得到的结果将是所有位全是0，然后利用第二个方法判断
 */
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
