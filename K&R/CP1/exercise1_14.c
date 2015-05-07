#include <stdio.h>

main()
{
  int tc[128];
  int c, i;

  for (i = 0; i < 128; ++i)
    tc[i] = 0;
  
  while ((c = getchar()) != EOF) {
    tc[c] += 1;
  }

  for (i = 0; i < 128; ++i) {
    if (tc[i] <= 0)
      continue;
    printf("%3c => ", i);
    int j;
    for (j = 0; j < tc[i]; ++j) {
      printf("=");
    }
    printf("\n");
  }
}
    
