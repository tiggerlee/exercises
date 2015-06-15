/*
 * 我们在一个 int 类型值为 32 位的机器上运行程序。这些值以补码形式表示，而且它们都是算术右移的。unsigned 类型的值也是 32 位的。
 *
 * 我们产生随机数 x 和 y，并且把它们转换成无符号数，显示如下：
 *
 * // Create some arbitrary values
 * int x = random();
 * int y = random();
 * // Convert to unsigned
 * unsigned ux = (unsigned) x;
 * unsigned uy = (unsigned) y;
 *
 * 对于下列每个 C 表达式，你要指出表达式是否总是为 1。如果它总是为 1，那么请描述其中的数学原理。否则，列举一个使它为 0 的参数示例。
 *
 * A. (x > y) == (-x < -y)
 * B. ((x + y) << 5) + x - y == 31 * y + 33 * x
 * C. ~x + ~y == ~(x + y)
 * D. (int)(ux - uy) == -(y - x)
 * E. ((x >> 1) << 1) <= x
 */

#include <stdio.h>
#include <limits.h>

int main() {
  // Create some arbitrary values
  int x = random();           
  int y = random();
  // Convert to unsigned
  unsigned ux = (unsigned) x;
  unsigned uy = (unsigned) y;
  
  /*
   * A. (x > y) == (-x < -y)
   * 当 y = INT_MIN 时，表达式结果为0
   * 关于 -INT_MIN 的值，请参考：http://stackoverflow.com/questions/3622347/1-int-minvalue-int-minvalue-is-this-a-bug
   */
  printf("(x > INT_MIN) == (-x < -INT_MIN): %d\n", (x > INT_MIN) == (-x < -INT_MIN));

  /*
   * B. ((x + y) << 5) + x - y == 31 * y + 33 * x
   * 表达式结果为1
   * 根据书中之前出现的规则，例如：x * 14，利用等式 14 = 2^3 + 2^2 + 2^1，x * 14 等价于 (x << 3) + (x << 2) + (x << 1)
   * 同样的，还可以利用等式 14 = 2^4 - 2^1，x * 14 同样等价于 (x << 4) - (x << 1)
   * 首先我们可以利用数学原理，将等式等价转换为：((x + y) << 5) + x - y == ((x << 5) + x) + ((y << 5) - y)
   * 根据上面给出的规则，(x << 5) + x 等价于 x * 33, (y << 5) - y 等价于 y * 31
   */
  printf("((x + y) << 5) + x - y == 31 * y + 33 * x: %d\n", ((x + y) << 5) + x - y == (x << 5) + x + (y << 5) - y); 
  printf("((x + y) << 5) + x - y == 31 * y + 33 * x: %d\n", ((x + y) << 5) + x - y == 31 * y + 33 * x); 

  /*
   * C. ~x + ~y == ~(x + y)
   *
   * 当 y 为 -1 时，表达式结果为0
   */
  printf("~x + ~y == ~(x + y): %d\n", ~x + ~(-1) == ~(x + (-1)));

  /*
   * D. (int) (ux - uy) == -(y - x)
   * 表达式值为1
   * (int) (ux - uy) == -(y - x) 等价于 (x - y) == -(y - x)
   * (x - y) 等价于 -(y - x)，所以表达式结果为1
   */
  printf("(int) (ux - uy) == -(y - x): %d\n", (int) (ux - uy) == -(y - x));

  /*
   * E. ((x >> 1) << 1) <= x
   *
   * 表达式结果为1
   * 因为 右移1位之后然后再左移一位，会将最低1位设置为0
   * 如果最后1位在移位之前为0，则移位之后结果等于之前的x
   * 如果最后1位在移位之前不为0，那么移位之后的结果小于x
   */
  printf("((x >> 1) << 1) <= x: %d\n", ((x >> 1) << 1) <= x);
  return 0;
}
