/*
 * 首先获取x的最高位的值 sign ＝ 1 或者 0
 * 然后用0 － sign 如果sign为1 则得到一个全部位都为1的数，若为0则全部位为0
 * 然后将上面的结果左移w－k位
 * 然后用｜计算上面左移的结果和刚开始逻辑右移得到结果，就得到了最终结果
 */
int sra(int x, int k) {
  /* Perform shift logically */
  int xsrl = (unsigned) x >> k;
  int w = sizeof(int) * 8;
  unsigned tmp = 1 << (w - 1);
  unsigned sign = tmp == (x & tmp);
  int mask = (0 - sign) << (w - k);
  int result = xsrl | mask;
  return result;
}

/*
 * 对于最高有效位为1的数字，方法中的操作会执行算数右移
 * 算数右移k位的结果就是比逻辑右移多了右边的k位的1
 * 然后构造一个右边开始k位为0，其余位为1的数值
 * 然后利用 & 操作消除算数右移带来的影响
 */
int srl(unsigned x, int k) {
  /* Perform shift arithmetically */
  unsigned xsra = (int) x >> k;
  int w = sizeof(int) * 8;
  /* 
   * 1 << (w - k) 的结果为一个长度为w，右起第k-1个位为1，其他位为0
   * 然后用上面生成的数值-1，得到一个右边开始k位为0，剩余位为1的值
   * 这样就构造出了需要的数值，用来和 xsra 执行 & 操作
   */
  unsigned mask = (1 << (w - k)) - 1;
  unsigned result = xsra & mask;
  return result;
}
