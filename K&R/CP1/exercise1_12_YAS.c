#include <stdio.h>

#define IN 0
#define OUT 1

int main()
{
  int state, c;

  state = OUT;
  while ((c = getchar()) != EOF) {
    if (c == ' ' || c == '\t' || c == '\n') {
      if (state == IN) {
	putchar('\n');
	state = OUT;
      }
    } else if (state == OUT) {
      state = IN;
      putchar(c);
    } else {
      putchar(c);
    }
  }
  return 0;
}
