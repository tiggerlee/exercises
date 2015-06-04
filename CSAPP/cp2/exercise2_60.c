#include <stdio.h>

/*
 * 以put_byte(0x12345678, 0xFF, 2) 为例：
 * 我们想要将第一个参数左起第三个字节的值(34)替换为FF
 * 首先构造两个数值：0x12000000 和 0x00005678，这样我们就可以利用这两个值和0xFF， 利用 | 操作符连接，得到我们需要的0x12FF5678
 */
unsigned put_byte(unsigned x, unsigned char b, int i) {
  /* 0xFF000000 */
  unsigned mark = 0xFFFFFFFF << ((i + 1) * 8);
  /* 得到我们要构造的第一个数值 */
  unsigned as1 = x & mark;
  /* 0xFFFF0000 */
  mark = 0xFFFFFFFF << (i * 8);
  /* 得到我们要构造的第二个数值 */
  unsigned as2 = x ^ (x & mark);
  /* 将要替换的数值执行右移操作，移动到要被替换位置 */
  unsigned place = b << (i * 8);
  unsigned result = as1 | as2 | place;
  return result;
}

int main() {
  unsigned origin_num = 0x12345678;
  unsigned char place_num = 0xAB;
  unsigned result1 = put_byte(origin_num, place_num, 2);
  unsigned result2 = put_byte(origin_num, place_num, 0);
  printf("%x replace with %x in 2ed byte is: %x\n", origin_num, place_num, result1);
  printf("%x replace with %x in 0 byte is: %x\n", origin_num, place_num, result2);
  return 0;
}
  
  
