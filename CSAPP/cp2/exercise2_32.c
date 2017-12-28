// 可以判断两个 int 相加是否溢出
int tadd_ok(int x, int y);

// 当 y 为 TMin 时，-y 的值还是TNin
// 此时如果 x 值为负数时，负数加 TMin 会负溢出，返回错误结果0
// 但是根据减法规则，当负数 x 减 TMin 等于 |TMin| - |x|，并没有溢出，应该返回结果1
// buggy version
int tsub_ok(int x, int y) {
    return tadd_ok(x, -y);
}

// correct version
int tsub_ok(int x, int y) {
    return (x < 0 && y == INT_MIN) || tadd_ok(x, -y);
}