#include <stdio.h>
#include <limits.h>

/*
 * 根据练习2.76 我们可以得到 x*5 可以表示为 (x << 2) + x
 * 然后在处理最后的除以8的时候，我们应该考虑到练习2.77中出现的负数舍入问题
 */
int mul5div8(int x) {
  x = (x << 2) + x;
  int sign = x & INT_MIN;
  sign && (x = x + (1 << 3) - 1);
  int result = x >> 3;
  return result;
}

int test(int x) {
  return 5 * x / 8;
}

int main() {
  int x = 7;
  printf("%d * 5 / 8 = %d\n", x, mul5div8(x));
  printf("%d * 5 / 8 = %d\n", x, test(x));
  x = -7;
  printf("%d * 5 / 8 = %d\n", x, mul5div8(x));
  printf("%d * 5 / 8 = %d\n", x, test(x));
  return 0;
}
