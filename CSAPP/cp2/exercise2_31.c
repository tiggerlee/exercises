/*
    x:[0111] = 7
    y:[0110] = 6 
    sum = x + y = 13 [01101]
    sum:[1101] = -3
    sum - x = -3 - 7 = -10
    -10:[10110]
    截取4位：[0110]，和y的值完全相同
    因为 (x + y) - x = y 一直成立，所以这个方法没办法检测到溢出
*/

int add_ok(int x, int y) {
    int sum = x + y;
    return (sum-x == y) && (sum-y == x);
}