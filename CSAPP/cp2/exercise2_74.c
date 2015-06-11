#include <stdio.h>
#include <limits.h>

/*
 * 参考这里：https://github.com/mofaph/csapp/blob/master/exercise/ex2-74.c
 * x - y的溢出情况有两种：
 * 当 x 为正数，y 为负数，结果为负数时
 * 当 x 为负数，y 为正数，结果为正数时
 * 这两种情况下说明计算结果溢出
 */
int tsub_ok(int x, int y) {
  int result = x - y;
  /*
   * 因为INT_MIN为10...0，即除了最高位为1，其他都为0，所以可以使用 x & INT_MIN来判断x的符号，等于0为正数，其他为负数
   */
  int pos_overlay = !(x & INT_MIN) && (y & INT_MIN) && (result & INT_MIN);
  int neg_overlay = (x & INT_MIN) && !(y & INT_MIN) && !(result & INT_MIN);
  return pos_overlay || neg_overlay;
}

int main() {
  printf("%d - %d = %d : %d\n", -2147483640, 2147483640, -2147483640 - 2147483640, tsub_ok(-2147483640, 2147483640));
  printf("%d - %d = %d : %d\n", 2147483640, -1000, 2147483640 - -1000, tsub_ok(2147483640, -1000));
  printf("%d - %d = %d : %d\n", 2147483640, 1000, 2147483640 - 1000, tsub_ok(2147483640, 1000));
  printf("%d - %d = %d : %d\n", 3640, -1000, 3640 - -1000, tsub_ok(3640, -1000));
  printf("%d - %d = %d : %d\n", -3640, -1000, -3640 - -1000, tsub_ok(-3640, -1000));
  printf("%d - %d = %d : %d\n", 0, -1000, 0 - -1000, tsub_ok(0, -1000));
  printf("%d - %d = %d : %d\n", 0, 1000, 0 - 1000, tsub_ok(0, 1000));
  printf("%d - %d = %d : %d\n", 100, 0, 100 - 0, tsub_ok(100, 0));
  printf("%d - %d = %d : %d\n", -100, 0, -100 - 0, tsub_ok(-100, 0));
  return 0;
}
