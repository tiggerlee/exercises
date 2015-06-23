typedef unsigned float_bits;

/* Compute -f, If f is NaN, then return f. */
float_bits float_negate(float_bits f) {
  unsigned exp = (f >> 23) & 0xFF;
  unsigned frac = f & 0x7FFFFF;

  if (exp == 0xFF && frac != 0) {
    return f;
  }

  /*
   * 用异或^来取-f的值，取-f，需要将原来的符号位取反，异或^1，如果原来为1，则结果为0，如果原来为0，结果为1，达到我们要的结果。*/
  return f ^ (1 << 31);
}
