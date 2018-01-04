void decode1(long *xp, long *yp, long *zp) {
    long tempx = *xp;
    long tempy = *yp;
    long tempz = *zp;
    *yp = tempx;
    *zp = tempy;
    *xp = tempz;
}