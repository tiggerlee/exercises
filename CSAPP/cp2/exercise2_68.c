#include <stdio.h>

/*
 * Examples: x = 0x78ABCDEF, n = 6 --> 0x3F, n = 17 --> 0x1FFFF
 *
 * 要达到题目要求的结果，首先需要一个从最低位起长度为n的位都为1，其他位为0的位向量，即可得到结果
 * 要得到上一步需要的位向量，可以用 (1 << n) - 1得到，但是要注意一个问题，就是n = w的时候，这样会出现移位长度等于位向量长度的情况
 * 所以需要处理n = w的特殊情况
 */
int lower_bits(int x, int n) {
  int w = sizeof(int) << 3;
  int mask = ~0;
  /* n = w时我们使用~0构造一个全部位为1的位向量，其他情况用上面给出的方法生成我们需要的位向量 */
  n == w || (mask = (1 << n) - 1);
  printf("mask now is %x\n", mask);
  return mask;
}

int main() {
  int x = 0x78ABCDEF;
  int s6 = 6;
  int s1 = 1;
  int s17 = 17;
  int s32 = 32;
  printf("x is %x:\n", x);
  printf("n is %d and result is %x\n", s6, lower_bits(x, s6));
  printf("n is %d and result is %x\n", s1, lower_bits(x, s1));
  printf("n is %d and result is %x\n", s17, lower_bits(x, s17));
  printf("n is %d and result is %x\n", s32, lower_bits(x, s32));
  return 0;
}
