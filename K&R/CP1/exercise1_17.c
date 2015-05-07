#include <stdio.h>

#define MAXLENGTH 1000

int getl(char s[], int lim);

int main()
{
  int len;
  int displaylen = 80;
  char cline[MAXLENGTH];
  
  while ((len = getl(cline, MAXLENGTH)) > 0) {
    if (len > displaylen)
      printf("%s", cline);
  }
}

int getl(char s[], int lim)
{
  int i, c;

  for (i = 0; i < lim - 1 && (c = getchar()) != EOF && c != '\n'; ++i) {
    s[i] = c;
  }

  if (c == '\n') {
    s[i] = '\n';
    ++i;
  }

  s[i] = '\0';
  return i;
}
