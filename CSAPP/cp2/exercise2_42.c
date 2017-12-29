int div16(int x) {
    int sign = x >> 31;
    int bias = sign & 0xF;
    int x_with_bias = x + bias; 
    return x_with_bias >> 4;
}