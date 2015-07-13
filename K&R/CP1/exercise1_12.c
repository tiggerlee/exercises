#include <stdio.h>

#define IN 0
#define OUT 1

main()
{
  int c, state;
  state = OUT;

  while ((c = getchar()) != EOF) {
    if (c == ' ' || c == '\n' || c == '\t') {
      if (state == IN) {
	printf("\n");
        state = OUT;
      }
    } else {
      putchar(c);
      if (state == OUT)
        state = IN;
    }
  }
}
