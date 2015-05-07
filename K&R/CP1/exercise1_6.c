#include <stdio.h>

main()
{
  int c;
  while ((c = getchar()) != EOF) {
    printf("%c is EOF: %d\n", c, c == EOF);
  }
}
