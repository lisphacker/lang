#include <stdio.h>
#include <math.h>

void trunc_vs_floor(float x) {
    printf("%f %f %f %d\n", x, floorf(x), truncf(x), (int) x);
}

int main() {
    trunc_vs_floor(2.5f);
    trunc_vs_floor(-2.5f);
}
