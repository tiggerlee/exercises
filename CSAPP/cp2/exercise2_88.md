我们在一个int类型为32位补码表示的机器上运行程序。float类型的值使用32位IEEE格式，而double类型的值使用64位IEEE格式。
我们产生随机整数x、y和z，并且把它们转换成double类型：

```c
/* Create some arbitrary value */
int x = random();
int y = random();
int z = random();

/* Convert to double */
double dx = (double) x;
double dy = (double) y;
double dz = (double) z;
```

对于下列的每个C表达式，你要指出表达式是否总是为1。如果它总是为1，描述其中的数学原理。否则，列举出使它为0的参数的例子。请注意，不能使用IA32机器运行GCC来测试你的答案，因为对于float和double，它使用的都是80位的扩展精度表示。

A. (double)(float) x == dx               // 当x = TMax时，超出了float的表示范围

B. dx + dy == (double) (x+y)             // 当x+y发生溢出的时候，dx+dy没有溢出的时候不为1，因为double表示的值范围比int大

C. dx + dy + dz == dz + dy + dx           // dx=1, dy=1e20, dz=-1e20, 因为浮点运算无结合性

D. dx * dy * dz == dz * dy * dx           // 不是总为1，因为浮点运算无结合性，运算结果可能有舍入

E. dx / dx == dy / dy                     // dx 或者 dy为0时不成立
