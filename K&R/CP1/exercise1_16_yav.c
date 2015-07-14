#include <stdio.h>

#define MAXLINE 10

int getl(char s[], int lim);
void copy(char to[], char from[]);

int main()
{
  int max, len;
  char line[MAXLINE];
  char longest[MAXLINE];

  max = 0;
  while ((len = getl(line, MAXLINE)) > 0) {
    if (len > max) {
      max = len;
      copy(longest, line);
    }
  }

  if (max > 0) {
    printf("The longest line is: %s", longest);
  }
  return 0;
}

int getl(char s[], int lim)
{
  int c, i;

  for (i = 0; (c = getchar()) != EOF; ++i) {
    /* 读取的字符长度小于lim-1时，将字符写入到当前字符数组中
     * 如果读取的字符长度等于lim-1时，在当前位置写入\0表示这是字符串的结尾
     * 并且不再继续读取字符，防止字符数组溢出
     */
    if (i < lim - 1) {
      s[i] = c;
    } else if (i == lim - 1) {
      s[i] = '\0';
    }

    /* 如果当前读取到的字符是换行符\n的话：
     * 如果当前读取的字符长度小于lim-1，那么在数组的下一位写入\0，表示字符读取结束
     * 最后返回当前长度 i+1 作为本次读取字符的长度
     */
    if (c == '\n') {
      if (i < lim - 1) {
        s[i+1] = '\0';
      }
      return i+1;
    }
  }
}

void copy(char to[], char from[])
{
  int i;
  i = 0;
  while ((to[i] = from[i]) != '\0')
    ++i;
}
