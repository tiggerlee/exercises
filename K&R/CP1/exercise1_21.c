#include <stdio.h>

#define TABSTOP 4

void spaces_to_tab(char s[], int len, int location);

int main() {
  int c, i;
  char spaces[TABSTOP];
  int space_count = 0;
  while ((c = getchar()) != EOF) {
    if (c == ' ') {
      if (space_count >= TABSTOP - 1) {
        spaces_to_tab(spaces, space_count, i);
      }
      spaces[space_count] = c;
      ++space_count;
      ++i;
    } else {
      if (c == '\n') {
        spaces_to_tab(spaces, space_count, i);
        i = 0;
      } else {
        if (space_count > 0) 
          spaces_to_tab(spaces, space_count, i);
        ++i;
      }
      putchar(c);
    }
  }
  return 0;
}

void spaces_to_tab(char s[], int len, int location) {
  if (space_count > (location % TABSTOP)) {
    
}
