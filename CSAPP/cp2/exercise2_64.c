/*
 * 首先构造一个偶数位全是1的数：0xAAAAAAAA
 * 然后利用 & 计算x 和构造出来的数，如果x至少有一个偶数位为1，那么得到的结果就不为0
 * 否则为0，然后利用两次取 !! 的操作，如果是非0的数值，结果为1，如果是0的数值，得到0
 */
int any_even_one(unsigned x) {
  int mask = 0xAAAAAAAA;
  return !!(x & mask);
}
