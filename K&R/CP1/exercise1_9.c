#include <stdio.h>

main()
{
  int c, count;

  count = 0;
  while ((c = getchar()) != EOF) {
    if (c != ' ') {
      putchar(c);
      count = 0;
    } else {
      if (count == 0)
	putchar(c);
      ++count;
    }
  }
}
