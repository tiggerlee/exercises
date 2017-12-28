```c
/* Prototype for library function strlen */
size_t strlen(const char *s);

/* Determine whether string s is longer than string t */
/* WARNING: This function is buggy */
int strlonger(char *s, char *t)
{
  return strlen(s) - strlen(t) > 0;
}
```

A. 当s没有t长的时候，函数还是会错误的返回1

B. 因为```strlen```返回的是一个无符号数，而s比t短的时候，```strlen(s) - strlen(t)```结果为负数，但是因为 site_t 是 unsigned 类型，
导致运算结果会被转换成一个很大的正数，导致函数出错。

C. 将函数内语句修改为```return strlen(s) > strlen(t)```.
