#include <stdio.h>

#define TABSTOP 4

int rep_tab(int location);

int main() {
  int c, i;
  i = 0;
  while ((c = getchar()) != EOF) {
    if (c == '\n') {
      i = 0;
      putchar(c);
    }else if (c == '\t') {
      int sps = rep_tab(i);
      int j;
      for (j = 0; j < sps; ++j) {
        putchar(' ');
        ++i;
      }
    } else {
      putchar(c);
      ++i;
    }

  }
  return 0;
}

int rep_tab(int location) {
  return TABSTOP - (location % TABSTOP);
}
