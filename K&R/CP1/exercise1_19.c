#include <stdio.h>

#define MAXLINE 1024 /* Assume the line length less than 1024 */

int getl(char s[], int lim);
void reverse(char s[], int len);

int main()
{
  int len;
  char line[MAXLINE];

  while ((len = getl(line, MAXLINE)) > 0) {
    /* Reverse the line which has more than one characters */
    if (len > 1) {
      printf("Before reverse: %s", line);
      reverse(line, len);
      printf("After reverse: %s", line);
    }
  }
}

int getl(char s[], int lim)
{
  int c, len;

  for (len = 0; len < lim-1 && (c = getchar()) != EOF && c != '\n'; ++len) {
    s[len] = c;
  }

  if (c == '\n') {
    s[len] = '\n';
    ++len;
  }

  s[len] = '\0';
  return len;
}

void reverse(char s[], int len)
{
  int lower, upper;
  lower = 0;
  upper = len - 2;
  while (lower < upper) {
    char tmp = s[lower];
    s[lower] = s[upper];
    s[upper] = tmp;
    ++lower;
    --upper;
  }
}
