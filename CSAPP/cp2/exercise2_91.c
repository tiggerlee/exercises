typedef unsigned float_bits;

/* Compute |f|. If f is NaN, then return f. */
float_bits float_absval(float_bits f) {
  /*
   * 解决这个问题，首先需要判断f是不是NaN，如果f为NaN，那么f的阶码为全为1并且小数位不为0
   * 所以先取得f的阶码位exp和小数位frac，如果是NaN，返回f，如果不是，返回|f|
   * 要取得|f|，只需要将符号位改为0即可，f为非负
   */
  unsigned exp = (f >> 23) & 0xFF;
  unsigned frac = f & 0x7FFFFF;
  if (exp == 0xFF && frac != 0) {
    return f;
  }
  return f & ((1 << 31) - 1);
}
  
