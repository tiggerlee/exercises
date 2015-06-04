int int_shifts_are_logical() {
  int x = ~0;
  int shifted_val = x >> 1;
  return x == shifted_val;
}
