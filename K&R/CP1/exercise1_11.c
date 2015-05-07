#include <stdio.h>

#define IN 1
#define OUT 0

main()
{
  int nc, nw, nl;
  int c, state;

  nc = nw = nl = 0;
  while ((c = getchar()) != EOF) {
    ++nc;
    if (c == '\n')
      ++nl;
    if (c == ' ' || c == '\t' || c == '\n')
      state = OUT;
    else if (state == OUT) {
      ++nw;
      state = IN;
    }
  }

  printf("There are %d characters, %d words and %d newlines\n", nc, nw, nl);
}
