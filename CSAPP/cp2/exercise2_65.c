#include <stdio.h>

/*
 * 要确定x的2进制中1的个数为偶数个还是奇数个
 * 用异或来达到目标，两个同为1的位，异或之后的结果为0
 * 这样我们就可以将x的分为高16位和低16位两部分，我们可以用右移16位的操作，来取得我们想要的两部分
 * 然后用异或获得这两部分的结果，为结果的后16位，然后再将结果的后16位分为高8位和低8位
 * 同样用异或获得结果，然后分为高4位和低4位，同样操作，直到高1位和第1位
 * 同样用异或获得结果，如果是0，说明有偶数个1
 * 然后用!(x & 1)来取得偶数个1返回1，奇数个返回0
 */
int even_ones(unsigned x) {
  x ^= x >> 16;
  x ^= x >> 8;
  x ^= x >> 4;
  x ^= x >> 2;
  x ^= x >> 1;
  return !(x & 1);
}

int main() {
  int even_one = 6;
  int odd_ones = 2;
  printf("%x has even ones? : %x\n", even_one, even_ones(even_one));
  printf("%x has even ones? : %x\n", odd_ones, even_ones(odd_ones));
  return 0;
}
