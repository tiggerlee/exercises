#include <stdio.h>

typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, int len) {
  int i;
  for (i = 0; i < len; i++)
    printf(" %.2x", start[i]);
  printf("\n");
}

void show_short(short x) {
  show_bytes((byte_pointer) &x, sizeof(short));
}

void show_long(long x) {
  show_bytes((byte_pointer) &x, sizeof(long));
}

void show_double(double x) {
  show_bytes((byte_pointer) &x, sizeof(double));
}

int main() {
  int val = 12345;
  short s_val = (short) val;
  long l_val = (long) val;
  double d_val = (double) val;
  /* Result on my PC
     OS: Ubuntu 14.04 LTS 64bit
     CPU: Intel Core-i3
  */
  
  /* 39 30 */
  show_short(s_val);

  /* 39 30 00 00 00 00 00 00 */
  show_long(l_val);

  /* 00 00 00 00 80 1c c8 40 */
  show_double(d_val);

  return 0;
}
