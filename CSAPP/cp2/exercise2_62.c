int int_shifts_are_logical() {
  /* 得到一个所有位都为1的数 */
  int x = ~0;
  /* 如果是算数右移，所有位应该还是1 */
  int shifted_val = x >> 1;
  /* 算数右移之后的结果应该和之前的相等 */
  return x == shifted_val;
}
