#include <stdio.h>

void count_recursive(size_t n) {
    fprintf(stderr, "n = %zu\n", n);
    count_recursive(n+1); // NOTE: infinite recursion (warning)
}

int main() {
    count_recursive(0);
}