```c
/* Determine whether arguments can be added without overflow */
int uadd_ok(unsigned x, unsigned y)
{
  unsigned result = x + y;
  return result >= x;
}
```