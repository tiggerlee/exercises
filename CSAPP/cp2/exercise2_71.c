/*
 * The buggy code
 * int xbyte(packed_t word, int bytenum) {
 *   return (word >> (bytenum << 3)) & 0xFF;
 * }
 *
 * A.如果截取的字节最高位为1，不能得到正确的结果。例如取第0个0xFF的字节，得到的是255，不是-1。
 * B.出现上面的问题，主要原因就是对于unsigned进行右移时，会执行逻辑右移
 * 所以要解决这个问题，首先将要截取的字节移到最高有效字节的位置，然后类型设置为有符号数，然后对有符号数执行右移，就是在执行算数右移，即可获得正确结果
 */
typedef unsigned packed_t;

int xbyte(packed_t word, int bytenum) {
  int left = word << ((3 - bytenum) << 3);
  return left >> 24;
}
