# 3.16

A.

``` c
void cond(long a, long *p) {
    if (p == NULL)
        goto DONE;
    if (a <= *p)
        goto DONE;
    *p = a;
    DONE:
        return;
}
```

B. 因为 && 是短路操作符，如果 p 是一个空指针的话，就会跳过 a 和 *p 的比较。