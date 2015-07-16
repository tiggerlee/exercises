#include <stdio.h>

#define TABSTOP 4

void print_chars(char s[], int len);
void space_to_tab(char s[], int len);

/*
 * 我的方法是一次读取长度为 TABSTOP个字符，如果最后一个字符是空格的话
 * 我们需要将末尾的空格替换为制表符
 * 如果末尾不是空格的话，保持原来的字符
 */

int main() {
  int c;
  char charters[TABSTOP];
  int len_char;

  len_char = 0;
  while ((c = getchar()) != EOF) {
    /* 如果读到了换行符，就算读取的字符数量没有达到TABSTOP的长度，也要处理
     * 这样可以保证每行的格式和替换之前保持一致
     */
    if (c == '\n') {
      space_to_tab(charters, len_char);
      len_char = 0;
      putchar(c);

    /* 读取了TABSTOP个字符之后，调用方法来判断对空格进行处理 */
    } else if (len_char >= TABSTOP) {
      space_to_tab(charters, len_char);
      len_char = 0;
      charters[len_char] = c;
      ++len_char;
    } else {
      charters[len_char] = c;
      ++len_char;
    }
  }
}

void space_to_tab(char s[], int len) {
  char c = s[len-1]; /* 读取字符数组最后一个字符 */

  /* 去除字符数组末尾连续的空格字符 */
  while (s[len-1] == ' ') {
    --len;
  }

  /* 如果字符数组的最后一个字符是空格
   * 则在去除了末尾连续空格之后的字符数组中加入制表符替换原来的空格
   */
  if (c == ' ') {
    s[len] = '\t';
    ++len;
  }

  print_chars(s, len);
}

void print_chars(char s[], int len) {
  int i;
  for (i = 0; i < len; ++i)
    putchar(s[i]);
}
