float sum(float *ar, int n) {
    int i;
    float sum = 0.0f;
    
    for (i = 0; i < n; i++)
        sum += ar[i];

    return sum;
}
