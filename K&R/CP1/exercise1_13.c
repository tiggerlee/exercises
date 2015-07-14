#include <stdio.h>

#define IN 0
#define OUT 1
#define MAXLENGTH 11
#define MAXHISTOGRAM 10

/* 打印输入中单词长度的直方图，长度1～10之间，超过10以上为一类来统计
 * 直方图用 = 来表示，=的数量代表该长度单词出现的数量，出现次数超过10次，用10个=加一个+表示超过了10次
 */

main()
{
  int c, state;
  int current_length;
  int length_of_words[10];
  int length_greater_ten;

  current_length = 0;
  state = OUT;
  length_greater_ten = 0;
  int i;
  for (i = 0; i < 10; ++i) {
    length_of_words[i] = 0;
  }
  while ((c = getchar()) != EOF) {
    if (c == ' ' || c == '\t' || c == '\n') {
      if (state == IN) {
        if (current_length >= MAXLENGTH) {
          length_greater_ten += 1;
        } else {
          length_of_words[current_length - 1] += 1;
        }
        state = OUT;
        current_length = 0;
      }
    } else {
      if (state = IN) {
        state = OUT;
      }
      ++current_length;
    }
  }

  for (i = 0; i < 10; ++i) {
    int l = length_of_words[i];
    if (l > 0) {
      printf("%3d: ", i + 1);
      int j;
      for (j = 0; j < l; ++j) {
        if (j >= MAXHISTOGRAM) {
          printf("+");
          break;
        }
        printf("=");
      }
      printf("\n");
    }
  }

  if (length_greater_ten > 0) {
    printf("%d+: ", MAXLENGTH - 1);
    int j;
    for (j = 0; j < length_greater_ten; ++j) {
      if (j >= MAXHISTOGRAM) {
        printf("+");
        break;
      }
      printf("=");
    }
    printf("\n");
  }
}
