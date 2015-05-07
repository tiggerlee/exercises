#include <stdio.h>

#define IN 0
#define OUT 1

main()
{
  int lw[10];
  int c, i, lother, length, state;

  lother = 0;
  length = 1;
  state = OUT;
  for (i = 0; i < 10; ++i)
    lw[i] = 0;

  while ((c = getchar()) != EOF) {
    if (c == ' ' || c == '\t' || c == '\n') {
      if (length <= 10) {
	lw[length - 1] += 1;
      } else {
	lother += 1;
      }
      length = 1;
      state = OUT;
    } else if (state == OUT) {
      state = IN;
    } else {
      ++length;
    }

  }

  for (i = 0; i < 10; ++i) {
    printf("%4d: ", i + 1);
    int j;
    for (j = 0; j < lw[i]; ++j) {
      printf("=");
    }
    printf("\n");
  }

  printf("%4s: ", ">10");
  for (i = 0; i < lother; ++i) {
    printf("=");
  }
  printf("\n");
}
