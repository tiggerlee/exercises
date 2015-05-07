#include <stdio.h>

main()
{
  int c, count;
  count = 0;

  while ((c = getchar()) != EOF) {
    if (c == ' ' || c == '\n' || c == '\t') {
      if (count == 0)
	printf("\n");
      ++count;
    } else {
      putchar(c);
      count = 0;
    }
  }
}
