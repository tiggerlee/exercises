/*
 * Return 1 when x can be represented as an n-bit 2's complement number; 0 otherwise
 * Assume 1 <= n <= w
 */

/*
 * 参见（https://github.com/mofaph/csapp/blob/master/exercise/ex2-70.c）的解答
 * 如果是一个数可以用n位的2进制补码表示，设w为最高位，那么观察w到n位，对于正数，w到n所有位都为0，对于负数，都为1
 * 那么对于正数，我们可以通过将n-1位和之后所有位设置为0，这时候如果所有位都为0，那么可以使用n位表示完全，反之则不行
 * 对于负数，先构造一个w到n位为1，其他位为0的位向量，然后将x的n-1位以及之后的位设置为0，然后比较二者是否相等来判断w到n位是否全为1，如果是则表示可以用n位表示完全，反之则不行
 */
int fits_bits(int x, int n) {
  int w = sizeof(int) << 3;
  int s = ~((1 << (n - 1)) - 1);
  x &= s;
  return !x || x == s;
}
