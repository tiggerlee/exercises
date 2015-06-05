#include <stdio.h>

/*
 * 要完成目标，如果有一个只保留了x的最后一个字节的值，其他字节全部为0，和一个保留了y除了最后一个字节全部为0，保留其他字节值的两个数，我们就可以用 | 操作得到我们要的结果
 * 1. x & 0xFF 的结果为：除了最后一个字节保留x原来的值，其他位全部为0
 * 2. y & 0xFF 的结果为：和上面一样，保留了y最后一个字节的原始值，其他为0
 * 3. y ^ (y & 0xFF) 的结果为：由上一个结果我们可以知道 y & 0xFF的值，而这个操作的结果为除了最后一个字节全部为0，其他位置保留了y的原始值
 * 然后我们结合第1步和第3步的结果，(x & 0xFF) | (y ^ (y & 0xFF)) 的结果就是我们要的结果
 */
int main() {
  int x = 0x89ABCDEF;
  int y = 0x76543210;
  int result = (x & 0xFF) | (y ^ (y & 0xFF));
  printf("The result is: %x\n", result);
  return 0;
}