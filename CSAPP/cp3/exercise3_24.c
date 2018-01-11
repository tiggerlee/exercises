long loop_while(long a, long b) {
    long result = 1;
    while (a < b) {
        result = (a + b) * result;
        a += 1;
    }
    return result;
}