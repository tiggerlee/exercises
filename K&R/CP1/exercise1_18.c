#include <stdio.h>
#include <string.h>

#define MAX 1024

int getl(char s[], int lim);

int main()
{
  int len;
  char line[MAX];

  while ((len = getl(line, MAX)) > 0) {
    printf("Before remove trailing blanks and tabs: %s", line);
    printf("Charaters in char array: ");
    int j;
    for (j = 0; j < strlen(line); ++j) {
      printf(" %d ", line[j]);
    }
    printf("\n");
    
    if (line[len-1] == '\n') {
      int i = len - 2;
      while (i >= 0 && (line[i] == ' ' || line[i] == '\t')) {
	--i;
      }

      if (i > 0) {
	line[i+1] = '\n';
	line[i+2] = '\0';
      }
    }

    if (len > 2) {
      printf("After remove trailing blanks and tabs: %s", line);
      printf("Charaters in char array: ");
      for (j = 0; j < strlen(line); ++j) {
	printf(" %d ", line[j]);
      }

      printf("\n\n");
    }
  }
}

int remove_trailing_blank(char s[], int len) {
}
  

int getl(char s[], int lim)
{
  int c, i;

  for (i = 0; i < lim-1 && (c = getchar()) != EOF && c != '\n'; ++i) {
    s[i] = c;
  }

  if (c == '\n') {
    s[i] = '\n';
    ++i;
  }

  s[i] = '\0';
  return i;
}
  
  
