/* Copy integer into buffer if space is available */
/* WARNING: The following code is buggy */
void buggy_copy_int(int val, void *buf, int maxbytes) {
  if (maxbytes - sizeof(val) >= 0)
    memcpy(buf, (void *) &val, sizeof(val));
}

/*
 * A. 上面的代码主要问题就是sizeof返回的是unsigned的int，maxbytes比它小的时候，负数转换为无符号数之后会产生一个特别大的值，导致这个条件总是成立
 * B. 直接比较 maxbytes >= sizeof(val) 的值，即可避免这个问题，为了避免负数的转换问题，首先保证 maxbytes > 0
 */

void copy_int(int val, void *buf, int maxbytes) {
  if (maxbytes > 0 && maxbytes >= sizeof(val))
    memcpy(buf, (void *) &val, sizeof(val));
}
