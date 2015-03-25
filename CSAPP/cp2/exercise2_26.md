```c
/* Prototype for library function strlen */
size_t strlen(const char *s);
```

```c
/* Determine whether string s is longer than string t */
/* WARNING: This function is buggy */
int strlonger(char *s, char *t)
{
  return strlen(s) - strlen(t) > 0;
}
```

A. 当s没有t长的时候，函数还是会错误的返回1
B. 因为```strlen```返回的是一个无符号数，而s比t短的时候，```strlen(s) - strlen(t)```结果为负数，但是比较的时候使用无符号数比较，
结果会变成一个很大的正数，导致函数出错。
C. 将函数内语句修改为```return strlen(s) > strlen(t)```.