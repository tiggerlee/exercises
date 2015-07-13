#include <stdio.h>

#define FIRSTBLANK 1
#define NOTFIRSTBLANK 0

main()
{
  int c, position;

  position = NOTFIRSTBLANK;
  while ((c = getchar()) != EOF) {
    if (c != ' ') {
      putchar(c);
      if (position == NOTFIRSTBLANK)
        position = FIRSTBLANK;
    } else {
      if (position == FIRSTBLANK) {
        putchar(c);
        position = NOTFIRSTBLANK;
      }
    }
  }
}
