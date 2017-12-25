#include <stdio.h>

void inplace_swap(int *x, int *y) {
    *y = *x ^ *y;
    *x = *x ^ *y;
    *y = *x ^ *y;
}

void reverse_array(int a[], int cnt) {
    int first, last;
    for (first = 0, last = cnt - 1;
         // 将 first <= last 修改为 first < last
         first < last;
         first++, last--)
        inplace_swap(&a[first], &a[last]);
}

void print_array(int a[], int cnt) {
    int i;
    for (i = 0; i < cnt; i++)
        printf(" %d", a[i]);
}

void reverse_even_array() {
    int a[] = {1, 2, 3, 4};
    printf("\nStart reverse: ");
    print_array(a, 4);
    reverse_array(a, 4);
    printf("\nAfter reverse: ");
    print_array(a, 4);
}

void reverse_odd_array() {
    int a[] = {1, 2, 3, 4, 5};
    printf("\nStart reverse: ");
    print_array(a, 5);
    reverse_array(a, 5);
    printf("\nAfter reverse: ");
    print_array(a, 5);
}
// A. 对于一个长度为奇数的数组，长度 cnt = 2k + 1，函数 reverse_array 最后一次循环中，first 和 last 的值均为 k
// B. 因为最后两个值均为k，指向了同一个数字，对于两个相同的数字执行异或操作，结果为0
// C. 将 for 循环中的判断语句 first <= last 修改为 first < last 即可。
int main(int argc, char * argv[]) {
    reverse_even_array();
    reverse_odd_array();
}