#include <stdio.h>

int bis(int x, int m);
int bic(int x, int m);

int bool_or(int x, int y) {
    int result = bis(x, y);
    return result;
}

/*
    x =                         1001 1100
    y =                         0101 1011
    bic(x, y) =                 1000 0100
    bic(y, x) =                 0100 0011
    bis(bic(x, y), bic(y, x)) = 1100 0111
    x ^ y =                     1100 0111
*/
int bool_xor(int x, int y) {
    int result = bis(bic(x, y), bic(y, x));
    return result;
}