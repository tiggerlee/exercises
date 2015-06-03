#include <stdio.h>

unsigned put_byte(unsigned x, unsigned char b, int i) {
  unsigned mark = 0xFFFFFFFF << ((i + 1) * 8);
  unsigned as1 = x & mark;
  mark = 0xFFFFFFFF << (i * 8);
  unsigned as2 = x ^ (x & mark);
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
  
  
