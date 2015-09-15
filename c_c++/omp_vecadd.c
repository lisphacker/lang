#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define N 1000000
#define RPT 10000

void vecadd_1(float *a, float *b, float *c, int n) {
    int i;
    for (i = 0; i < n; i++)
        c[i] = a[i] + b[i];
}

void vecadd_2(float *a, float *b, float *c, int n) {
    int i;
#pragma omp parallel for
    for (i = 0; i < n; i++)
        c[i] = a[i] + b[i];
}

void bench(float *a, float *b, float *c, int n, void (*f)(float *, float *, float *, int)) {
    struct timespec start, end;
    int r;
    
    clock_gettime(CLOCK_REALTIME, &start);
    for (r = 0; r < RPT; r++)
        f(a, b, c, N);
    clock_gettime(CLOCK_REALTIME, &end);

    double fstart = (double) start.tv_sec + (double) start.tv_nsec * 1e-9;
    double fend = (double) end.tv_sec + (double) end.tv_nsec * 1e-9;

    printf("%.3f\n", fend - fstart);
 }
           
int main() {
    float *a, *b, *c;
    int i;
    
    a = (float *) malloc(N * sizeof(float));
    b = (float *) malloc(N * sizeof(float));
    c = (float *) malloc(N * sizeof(float));

    if (a == NULL ||  b == NULL || c == NULL) {
        fprintf(stderr, "malloc() error");
        return -1;
    }

    for (i = 0; i < N; i++)
        a[i] = b[i] = (float) i;

    bench(a, b, c, N, vecadd_1);
    bench(a, b, c, N, vecadd_2);
    
    free(c);
    free(b);
    free(a);
    
}
