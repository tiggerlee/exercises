#include <stdio.h>
#include <limits.h>

/*
 * 计算x/2^k，x为正数的时候，可以使用右移 k 位得到正确的结果
 * 当x为负数的时候，在舍入的时候，会产生不是向 0 舍如的问题
 * 解决方法是 x 加上一个偏置值 (1 << k) - 1，然后再右移 k 位
 */
int divide_power2(int x, int k) {
  /* 首先判断 x 是不是负数 */
  int sign = x & INT_MIN;
  /* 然后根据 x 是不是负数，来判断要不要加上偏置值 */
  sign && (x = x + (1 << k) - 1);
  return (x >> k);
}

int main() {
  printf("%d\n", divide_power2(19, 3));
  printf("%d\n", divide_power2(-19, 3));
  printf("%d\n", 19 / 8);
  printf("%d\n", -19 / 8);
  return 0;
}
