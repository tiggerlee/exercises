#include <stdio.h>

/*
 * 根据书中之前出现的规则，例如：x * 14，利用等式 14 = 2^3 + 2^2 + 2^1，x * 14 等价于 (x << 3) + (x << 2) + (x << 1)
 * 同样的，还可以利用等式 14 = 2^4 - 2^1，x * 14 同样等价于 (x << 4) - (x << 1)
 */
int main() {
  int x = 3;
  int result, k;

  /*
   * A. K = 5
   * 5 = 2^2 + 2^0
   */
  k = 5;
  result = (x << 2) + x;
  printf("%d * %d = %d\n", x, k, result);

  /*
   * A. K = 9
   * 9 = 2^3 + 2^0
   */
  k = 9;
  result = (x << 3) + x;
  printf("%d * %d = %d\n", x, k, result);

  /*
   * A. K = 30
   * 30 = 2^5 - 2^1
   */
  k = 30;
  result = (x << 5) - (x << 1);
  printf("%d * %d = %d\n", x, k, result);

  /*
   * A. K = -56
   * -56 = 2^3 - 2^6
   */
  k = -56;
  result = (x << 3) - (x << 6);
  printf("%d * %d = %d\n", x, k, result);
  return 0;
}
