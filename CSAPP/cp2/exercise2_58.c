#include <stdio.h>

/*
 * 首先使用一个int值为1的数字
 * 这时候在小端表示的机器中，他的字节排列为:[0000 0001][0000....0000]
 * 如果是在大端表示的机器中则为:[0000....0000][0000 0001]
 * 接下来我们将这个int的指针强制转型为一个char类型的指针
 * 然后取出指针指向位置的值，即刚刚int存储中第一个字节的值
 * 如果等于1，则表示当前机器为小端法表示，如果不为1，则为大端机器
 */
int is_little_endian() {
  int val = 1;
  char *p = (char *) &val;
  return *p == val;
}

int main() {
  if (is_little_endian)
    printf("Little endian\n");
  else
    printf("Big endian\n");
  return 0;
}
  
