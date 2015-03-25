```c
/* WARNING: This is a buggy code */
float sum_elements(float a[], unsigned length)
{
  int i;
  float result = 0;
  for (i = 0; i <= length-1; i++)
    result += a[i];
  return result;
}
```

因为length为无符号类型，在计算```length-1```时，按照无符号的运算规则，将会产生一个所有位都是1的大数，这样会导致循环条件在很长时间内都为真，
循环内会访问超出数组长度的元素，修改的时候将参数```length```声明为```int```类型或者将循环判断条件```i <= length-1```修改为```i < length```。