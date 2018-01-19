struct ELE {
    long v;
    struct ELE *p;
};

long fun(struct ELE *ptr) {
    long val = 0;
    while (ptr) {
        val += ptr->v;
        ptr = ptr->p; 
    }
    return val;
}