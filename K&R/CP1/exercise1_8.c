#include <stdio.h>

main()
{
  long blanks, tabs, newlines;
  int c;

  blanks = tabs = newlines = 0;
  while ((c = getchar()) != EOF) {
    if (c == ' ')
      ++blanks;

    if (c == '\t')
      ++tabs;

    if (c == '\n')
      ++newlines;
  }

  printf("There are %ld blanks, %ld tabs and %ld newlines\n", blanks, tabs, newlines);
}
