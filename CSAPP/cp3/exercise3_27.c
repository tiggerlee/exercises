fact_while(long n) {
    long i = 2;
    long result = 1;
    if (i > n) {
        goto done;
    }
    loop:
        result *= i;
        i++;
        if (i <= n) {
            goto loop;
        }
    done:
        return result;
}