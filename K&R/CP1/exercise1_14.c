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
    /* 如果当前字符为 \t，则打印字符格式的\t，而不是打印一个制表符 
     * \n 同样的处理
     * 如果当前字符串为空格的时候，打印SPACE来代替打印一个空格
     * */
    if (i == '\t')
      printf("\\t => ");
    else if (i == '\n') 
      printf("\\n => ");
    else if (i == ' ')
      printf("SPACE => ");
    else
      printf("%3c => ", i);
    int j;
    for (j = 0; j < tc[i]; ++j) {
      printf("=");
    }
    printf("\n");
  }
}
    
