/*
 * 分配给你一个任务，编写一个C函数来计算2^x的浮点表示。你意识到完成这个任务的最好方法是直接创建结果的IEEE单精度表示。当x太小时，你的程序将返回0.0。当x太大时，它会返回正无穷大。填写下列代码的空白部分，以计算出正确的结果。假设函数u2f返回的浮点值与它的无符号参数有相同的位表示。
 *
 * 单精度的浮点数在IEEE的表示由1个符号位，8个阶码位以及23个小数位组成，偏置量为127
 */

float fpwr2(int x) {
  /* Result exponent and fraction */
  unsigned exp, frac;
  unsigned u;

  /* exp 8位可以表示最小的值为 1-127 = -126, 然后加上23位小数，如果x小于-126-23，即x小于-149对于单精度浮点数来说，太小，无法表示，返回0.0 */
  if (x < -149) {
    /* Too small. Return 0.0 */
    exp = 0;
    frac = 0;
  } else if (x < -126) { /* 非规格化的单精度表示x小于-126 */
    /* Denormalized result. */
    exp = 0;
    frac = 1 << (x + 149);
  } else if (x < 129) { /* 规格化表示x位于-126到128之间 */
    /* Normalized result. */
    exp = x + 127;
    frac = 0;
  } else {
    /* Too big. Return +oo */
    exp = 0xFF;
    frac = 0;
  }

  /* Pack exp and frac into 32 bits */
  u = exp << 23 | frac;
  /* Return as float */
  return u2f(u);
}
