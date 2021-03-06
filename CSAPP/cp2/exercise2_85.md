***

与 Intel 兼容的处理器也支持“扩展精度”浮点形式，这种格式具有 80 位字长，被分成 1 个符号位、k = 15 个阶码位、1 个单独的整数位和 n = 63 个小数位。整数位是IEEE 浮点表示中隐含位的显式副本。也就是说，对于规格化的值它等于 1，对于非规格化的值它等于 0。填写小表，给出用这种格式表示的一些“有趣的”数字的近似值。

***

对于上述的浮点数表示，k = 15，阶码偏置量为： 2^14 - 1 = 16383

最小的正非规格化数为所有位为0，最低位为1的数，所以最小的正非规格化数表示为：0x0000 0000 01，阶码M = 1 - 18383 = -16382，同时有n = 63 个小数位，那么它的值为 2^-16382 * 2 ^ -63 = 2^-16445

最小的正规格化数为：0x0001 0000 00，阶码M = 1 - 16383 = -16382，所以它的值为2^-16382

最大的规格化数为：0x7FFE FFFF FF，阶码M = 16383，所以它的值为(2 - 2^-63) * 2^16383

| 描述                 | 扩展精度            |                |
|----------------------|---------------------|----------------|
|                      |值                   |十进制          |
|最小的正非规格化数    |2^-16445             |                |
|最小的正规格化数      |2^-16382             |                |
|最大的规格化数        |(2-2^-63) * 2^16383  |                |
