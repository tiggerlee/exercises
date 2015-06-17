/*
 * 参考这里的解答：https://github.com/mofaph/csapp/blob/master/exercise/ex2-83.c
 * 排除掉NaN的情况，可以分为下面四种情况处理：
 * 1. 两个都为0，不管是+0还是-0，可以通过将ux和uy左移一位之后，两者是否都等于0来判断
 * 2. 两个数字符号不同，如果x >= 0 并且y < 0，那么x大于y，否则x小于y
 * 3. 当两个数都是大于等于0的数，那么比较ux和uy的大小就可以
 * 4. 当两个数都是小于0的时候，同样比较ux和uy的大小，这部分大的数，它本来的值更小
 */
int float_ge(float x, float y) {
  unsigned ux = f2u(x);
  unsigned uy = f2u(y);
  /* Get the sign bits */
  unsigned sx = ux >> 31;
  unsigned sy = uy >> 31;

  /* Give an expression using only ux, uy, sx, and sy */
  return ((ux << 1) == 0 && (uy << 1) == 0) || /* 第一种情况 */
    (!sx && sy) || /* !sx表示x大于等于0，sy表示y小于0 */
    (!sx && !sy && ux >= uy) || /* 第三种情况 */
    (sx && sy && ux <= uy); /* 第四种情况 */
}
